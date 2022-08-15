<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<div align="center">
    <img src="public/logo_cropped_sm.jpg" alt="Logo">
    <h3>Service Design Studio 2022</h3>
    <p align="center">
        A joint collaboration between SUTD and RSAF
        <br />
        <a href="https://docs.google.com/document/d/1wofgAExZuK5OeUTY3C9R3AckDEN8BlkFRwZYfhAtjK0/edit?usp=sharing">Design Workbook</a>
        .
        <a href="https://www.youtube.com/watch?v=SfcRNK891qw">View Demo</a>
        ·
        <a href="https://sites.google.com/mymail.sutd.edu.sg/sds-rsaf-amadeus/home?authuser=0">Google Sites</a>
    </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project
As an information portal, AMADEUS allows admin users to upload important articles, which are tagged, categorised and summarised by varying forms of artificial intelligence. Making use of Google's Cloud APIs, AMADEUS is able to effectively tackle the large diversity and high volumes of relevant information for its users.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
### Prerequisites
- Base configuration
  - For Windows,setup [Windows Subsystem for Linux (WSL)](https://www.youtube.com/watch?v=DED9YZWVbO8&t) and follow the step below using WSL
  - For MacOS, install homebrew:
  ```shell
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```
- Install [Ruby Version Manager](https://rvm.io/rvm/install) 
  - WSL:
    - Install rvm:
    ```shell
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    \curl -sSL https://get.rvm.io | bash
    ```
  - MacOS:
    ```shell
    # Install GPG
    brew install gpg

    # Trust Keys
    echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg --import-ownertrust
    echo 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:6: | gpg --import-ownertrust

    # Import Keys
    curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

    # Install RVM
    \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
    ```
- Add rvm to `$PATH` in `.bashrc` or `.zshrc`
  ```shell
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
  ```
  - Restart shell and check version
  ```shell
  exec bash # exec zsh
  rvm -v
  ```
- Install Ruby 3.0.0
```shell
# Install
rvm install 3.0.0

# Check
rvm list rubies

# Use ruby
rvm use 3.0.0
```
- Install Redis
  - WSL
  ```shell
  sudo apt update
  sudo apt install redis-server
  ```
  - MacOS:
  ```shell
  brew install redis
  ```
- Install Python 3.9 and pip
  - WSL
  ```shell
  sudo apt update
  sudo apt install software-properties-common -y
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt install python3.9 -y
  sudo apt install python3-pip python3.9-distutils -y
  python3.9 -m pip install pip
  ```
  - MacOS
  ```shell
  brew install python@3.9
  ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Installation
1. Clone the repo
```shell
git clone https://github.com/Service-Design-Studio/final-project-group-5-amadeus.git
```
2. Install gem libraries
```shell
bundle install
```
3. Setup database
```shell
rake db:create db:migrate db:seed
```
4. Run AI microservices
   1. Install python virtual environment under `./lib/assets` and activate
   ```shell
   cd lib/assets
   python3.9 -m venv env  
   source env/bin/activate
   ```
   2. Install dependencies (might need install [Rust](https://www.rust-lang.org/tools/install) to build `transformers`)
   ```shell
   pip install flask torch transformers
   ```
   3. In 1 separate terminal, run flask app in port `5001`
   ```shell
   python transformers_model.py
   ```
5. Run Rails application
```shell
foreman start -f Procfile_test.dev
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Testing
- Acceptance and System Testing using Cucumber under [./features](./features)
  - Capybara helper under [./features/support/world_extensions](./features/support/world_extensions.rb)
  - all other step definitions under [.features/step_definitions](.features/step_definitions)
- Unit Testing using Rspec under [./spec](./spec)
- Fuzz Testing under [./app/fuzz](./app/fuzz)
<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Acknowledgments
1. Tran Nguyen Bao Long [@TNBL265](https://github.com/TNBL265) (Project Manager + Technical Lead)
2. Timothy Wee [@weetimo](https://github.com/weetimo) (Scrum Master + ML Engineer)
3. Wang Zhao [@zhaaaoo](https://github.com/zhaaaoo) (Fullstack Developer)
4. Henry Lian [@Hentard](https://github.com/Hentard) (Frontend Dev + UI/UX Designer)
5. Ernest Lim [@Anteloped](https://github.com/Anteloped) (Backend Dev + DevOps)
6. Tron Ng [@gnnort](https://github.com/gnnort) (Backend Dev + QA Engineer)
<p align="right">(<a href="#readme-top">back to top</a>)</p>
