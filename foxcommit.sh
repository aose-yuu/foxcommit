#!/bin/bash

main() {
  try commit
  catch $?
}

commit() {
  clear

  read -p "No: " commit_number
  read -p "Commit Message: " commit_message 
  joined_number_message="No.${commit_number}_${commit_message}"
  selected_type=''
  selected_detail_type=''
  commit_type=''
  commit_reason=''

  clear

  types[0]=Front
  types[1]=Back
  types[2]=Java
  types[3]=その他インフラ

  while :
  do
  select type in "${types[@]}";
  do
    selected_type=$type
    case "$type" in

      Front)
        detail_types[0]=Viewer
        detail_types[1]=Navigator
        detail_types[2]=Tree
        detail_types[3]=Info
        detail_types[4]=Crawler
        detail_types[5]=Communication
        detail_types[6]=Vuex
        detail_types[7]=その他
        
        while :
        do
        select detail_type in "${detail_types[@]}";
        do
          case "${detail_type}" in
            Viewer | Navigator | Tree | Info | Crawler | Communication | Vuex | その他)
              selected_detail_type=${detail_type}
              break ;;

            *)
              echo "1から8までの数値を入力してください。"
              ;;
          esac
        done
        break
        done
        break ;;

      Back)
        detail_types[0]=Controllers
        detail_types[1]=dbs系
        detail_types[2]=function
        detail_types[3]=job
        detail_types[4]=routes
        detail_types[5]=validator
        
        while :
        do
        select detail_type in "${detail_types[@]}";
        do
          case "${detail_type}" in
            Controllers | dbs系 | function | job | routes | validator)
              selected_detail_type=${detail_type}
              break ;;

            *)
              echo "1から6までの数値を入力してください。"
              ;;
          esac
        done
        break
        done
        break ;;

      Java)
        detail_types[0]=Processing
        detail_types[1]=office-render
        
        while :
        do
        select detail_type in "${detail_types[@]}";
        do
          case "${detail_type}" in
            Processing | office-render)
              selected_detail_type=$detail_type
              break ;;

            *)
              echo "1から2までの数値を入力してください。"
              ;;
          esac
        done
        break
        done
        break ;;

      その他インフラ)
        detail_types[0]=mongo
        detail_types[1]=elasticsearch
        detail_types[2]=その他
        
        while :
        do
        select detail_type in "${detail_types[@]}";
        do
          case "${detail_type}" in
            mongo | elasticsearch | その他)
              selected_detail_type=$detail_type
              break ;;

            *)
              echo "1から3までの数値を入力してください。"
              ;;
          esac
        done
        break
        done
        break ;;

      * )
        echo "1から4までの数値を入力してください。"
        ;;
    esac
  done
  break
  done

  commit_type="${selected_type}-${selected_detail_type}"

  clear

  read -p "Reason: " commit_reason


  result_commit="git commit -F- <<EOF
  ${joined_number_message}
  ${commit_type}
  ${commit_reason}
  EOF"

  clear

  echo ${joined_number_message}
  echo ${commit_type}
  echo ${commit_reason}

  while :
  do
    read -p "この内容でコミットします。よろしいですか？(y/n): " answer
    case $answer in
      [Yy]*)
        eval "${result_commit}"
        break ;;
      [Nn]*)
        echo "コミットをキャンセルしました。"
        break ;;
      *)
        ;;
    esac
  done
}

try() {
  "$@"
  return $?
}

catch() {
  local exit_status=$1
  if [ ${exit_status} -ne 0 ]; then
    echo "Error: command failed with exit status ${exit_status}"
  fi
}

main
