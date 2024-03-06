#!/bin/bash
count=0
while true
 do
 if [ $count -eq 0 ]; then
 echo "パスワードマネージャーへようこそ！"
 echo "あなたのGPGキーで設定したユーザー名を入力してください。"
 read gpg_name
 gpg_name="${gpg_name:?GPGのユーザー名を設定してください。}"
 fi
 ((count++))
 read -p $'次の選択肢から入力してください(Add Password/Get Password/Exit)：' Select

 case "$Select" in
  *"Add Password" )
  read -p "サービス名を入力してください：" ServiceName
  read -p "ユーザー名を入力してください：" UserName
  read -p "パスワードを入力してください：" Password
  gpg -d apprentice.asc > apprentice 2> /dev/null
  printf "%s,%s,%s\n" "$ServiceName" "$UserName" "$Password" >> ./apprentice
  gpg -r "$gpg_name" -ea apprentice
  echo "パスワードの追加は成功しました。"
  #\n次の選択肢から入力してください(Add Password/Get Password/Exit)：' Select
    ;;
    
  *"Get Password" )
  read -p "サービス名を入力してください：" LinkService
  gpg -d apprentice.asc > apprentice 2> /dev/null
  
  if grep -q "$LinkService" ./apprentice; then
   ServiceName=$(grep "$LinkService" ./apprentice | cut -d , -f 1)
   UserName=$(grep "$LinkService" ./apprentice | cut -d , -f 2)
   Password=$(grep "$LinkService" ./apprentice | cut -d , -f 3)

   echo "サービス名："$ServiceName
   echo "ユーザー名："$UserName
   echo "パスワード："$Password

  else
   echo "そのサービスは登録されていません。"
  fi
  ;;

*"Exit")
echo "Thank you!"
rm apprentice
exit
;;

*)
echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
;;
esac
done
