# add github completion function to path
fpath=($ZSH/plugins/github $fpath)
autoload -U compinit
compinit -i

# variables
ZSH_PLUGIN_GITHUB_URL="https://github.com/api/v2/json"

# functions
function github {
  # Test for proper env variables
  
  if [[ ! -n $ZSH_PLUGIN_GITHUB_USERNAME ]] || \
     [[ ! -n $ZSH_PLUGIN_GITHUB_TOKEN ]] then
    echo "You much set the env variables in ~/.zshrc: \n\
ZSH_PLUGIN_GITHUB_USERNAME => your github Username.\n\
ZSH_PLUGIN_GITHUB_TOKEN => located at account setting \\ Account Admin"
    return
  fi
  
  #subcomands::
  
  if [[ "$1" == "new" ]] then
    github_repos_create $2 $3 $4
  elif [[ "$1" == "fork" ]] then
    github_repos_fork $2 $3 $4 
  else
    echo "Help commands"
  fi
  
}

function github_repos_fork {
  if [[ ! -n $1 ]] || [[ ! -n $2 ]] then
    echo "Syntax: github fork user repo[ directory]"
  else
    curl \
      -F "login=$ZSH_PLUGIN_GITHUB_USERNAME"\
      -F "token=$ZSH_PLUGIN_GITHUB_TOKEN"\
      $ZSH_PLUGIN_GITHUB_URL/repos/fork/$1/$2
    if [[ -n $3 ]] then
      git clone git@github.com:$ZSH_PLUGIN_GITHUB_USERNAME/$2.git $3
    fi
  fi
}
function github_repos_create {
  if [[ ! -n $1 ]] then
    echo "Syntax: github new RepoName [description [homepage]]"
  else
    curl \
      -F "login=$ZSH_PLUGIN_GITHUB_USERNAME"\
      -F "token=$ZSH_PLUGIN_GITHUB_TOKEN"\
      -F "name=$1"\
      -F "description=$2"\
      -F "homepage=$3"\
      $ZSH_PLUGIN_GITHUB_URL/repos/create
    if [[ -d .git ]] then
      git remote add origin git@github.com:$ZSH_PLUGIN_GITHUB_USERNAME/$1.git
    fi
  fi
}