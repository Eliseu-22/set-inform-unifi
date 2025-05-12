
# 🔄 Script: UniFi Set-Inform Automático

Este script Bash automatiza o envio do comando `set-inform` para vários Access Points (APs) UniFi usando SSH. Ideal para cenários em que os APs estão em redes separadas, precisam ser reassociados com a controladora, ou após reset.

---

## 📦 Requisitos

- Linux / WSL / macOS com:
  - `bash`
  - `sshpass`
  - `ping`
  - `ssh`
  - `ssh-keygen`
- Acesso SSH habilitado nos APs UniFi

---

## ⚙️ Configurações

Edite o script e configure os seguintes parâmetros:

```bash
CONTROLADOR_IP="SEU_IP_DA_CONTROLADORA"
PORTA="8080"

AP_LOGIN="SEU_USUARIO"
AP_SENHA="SUA_SENHA"

AP_IPS=("192.168.X.X" "192.168.X.X" "192.168.X.X")  # IPs reais dos seus APs
```

---

## 📝 Log

- O script registra todas as ações em um arquivo de log:
  ```
  /mnt/script_unifi/log-inform.log
  ```
- Mantém apenas as últimas 100 linhas para evitar crescimento excessivo do arquivo.

---

## ▶️ Como usar

Dê permissão de execução ao script:

```bash
chmod +x set-inform-safe.sh
```

Execute:

```bash
./set-inform-safe.sh
```

---

## 🛠️ O que ele faz

1. Para cada IP listado:
   - Remove a chave SSH antiga (se houver)
   - Verifica se o AP está online via `ping`
   - Conecta via SSH e executa `set-inform`
2. Gera logs de sucesso ou erro por AP
3. Trunca o log para manter no máximo 100 linhas

---

## ❗ Segurança

> **Nunca suba sua senha ou IPs reais no GitHub.**  
> Use arquivos de configuração externa ou variáveis de ambiente em ambientes reais.

---

## 🤝 Contribuição

Este script é gratuito e pode ser melhorado por qualquer pessoa. Pull requests são bem-vindos!

---

## 🧾 Licença

MIT License © [Seu Nome ou Organização]


---

## 🐧 Como subir este projeto para o GitHub via terminal no Linux

### Pré-requisitos:
- Git instalado: `sudo apt install git`
- Conta no GitHub já autenticada com token ou cache de login

---

### 1. Clone o repositório vazio que você criou

```bash
git clone https://github.com/SEU_USUARIO/set-inform-unifi.git
cd set-inform-unifi
```

> Substitua `SEU_USUARIO` pelo seu nome de usuário real no GitHub.

---

### 2. Copie os arquivos para a pasta

Coloque os arquivos `set-inform-safe.sh` e `README.md` dentro dessa pasta (pode ser com `cp` ou arrastando via interface gráfica):

```bash
cp /caminho/para/set-inform-safe.sh .
cp /caminho/para/README-set-inform.md ./README.md
```

---

### 3. Suba para o GitHub

```bash
git add .
git commit -m "Primeiro commit do script set-inform automático"
git push origin main
```

> Se der erro com `main`, tente:  
> `git push -u origin master`

---

### 📝 Pronto!

Agora o projeto está publicado no seu repositório do GitHub.
Você pode compartilhar o link com outras pessoas, e elas poderão baixar, contribuir ou usar livremente.
