# Install RVM
sudo apt update
sudo apt install -y curl g++ gcc autoconf automake bison libc6-dev libffi-dev libgdbm-dev \
                  libncurses5-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 \
                  zlib1g-dev libgmp-dev libreadline-dev libssl-dev
gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# Install ruby 3.0.0
rvm install ruby-3.0.0

# Add the below to ~/.bashrc
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use ruby-3.0.0

# Setup socket
curl -O https://portal.socketxp.com/download/linux/socketxp && chmod +wx socketxp && sudo mv socketxp /usr/local/bin

sudo socketxp login # [your socketxp auth id]
sudo nohup socketxp connect http://localhost:3000 > socket_log.txt 2>&1 &

# Clone repo
sudo apt update
sudo apt install -y git
git clone https://github.com/Service-Design-Studio/final-project-group-5-amadeus.git
cd final-project-group-5-amadeus

# Rails
bundle install
rake db:create db:migrate db:seed
rails s

# Set ENV for
# RAILS_ENV
# RAILS_SERVE_STATIC_FILES
# RAILS_LOG_TO_STDOUT
# SECRET_KEY_BASE
# PG_USER_KEY
# PG_URL
# FLASK_URL
# REDIS_URL
# NLP_API_KEY

