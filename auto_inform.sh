#!/bin/bash

# Caminho para o arquivo de log
LOG_FILE="/mnt/script_unifi/log-inform.log"
MAX_LINES=100

# Função para truncar o arquivo de log se ultrapassar 100 linhas
truncate_log() {
    local log_file=$1
    local max_lines=$2

    if [[ $(wc -l < "$log_file") -gt $max_lines ]]; then
        echo "Truncando o log, mantendo as últimas $max_lines linhas..." | tee -a "$log_file"
        tail -n $max_lines "$log_file" > "${log_file}.tmp" && mv "${log_file}.tmp" "$log_file"
    fi
}

# IP da controladora Unifi (ajuste conforme necessário)
CONTROLADOR_IP="SEU_IP_DA_CONTROLADORA"
PORTA="8080"

# Login e senha do AP (usado via SSH)
AP_LOGIN="SEU_USUARIO"
AP_SENHA="SUA_SENHA"

# Lista de IPs dos APs Unifi
AP_IPS=("192.168.X.X" "192.168.X.X" "192.168.X.X") # Substitua pelos IPs reais

echo "Execução iniciada em $(date)" | tee -a "$LOG_FILE"

# Função para enviar o comando 'set-inform' via SSH para os APs
inform_ap() {
    local ap_ip=$1
    echo "Fazendo login e enviando comando 'set-inform' para o AP com IP $ap_ip..." | tee -a "$LOG_FILE"

    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$ap_ip" >/dev/null 2>&1

    if ping -c 1 -W 2 "$ap_ip" >/dev/null; then
        sshpass -p "$AP_SENHA" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$AP_LOGIN@$ap_ip" \
            "/usr/bin/syswrapper.sh set-inform http://$CONTROLADOR_IP:$PORTA/inform" \
            && echo "Comando enviado com sucesso para $ap_ip" | tee -a "$LOG_FILE" \
            || echo "Erro ao conectar ao AP $ap_ip via SSH." | tee -a "$LOG_FILE"
    else
        echo "AP $ap_ip está offline ou inacessível." | tee -a "$LOG_FILE"
    fi
}

for ap_ip in "${AP_IPS[@]}"; do
    inform_ap "$ap_ip"
done

truncate_log "$LOG_FILE" "$MAX_LINES"

echo "Processo concluído em $(date)" | tee -a "$LOG_FILE"
