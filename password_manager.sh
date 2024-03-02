#!/bin/bash
while true
 do
 echo "パスワードマネージャーへようこそ！"
 read -p $'次の選択肢から入力してください(Add Password/Get Password/Exit)：' Select

 case "$Select" in
  *"Add Password" )
  read -p "サービス名を入力してください：" ServiceName
  read -p "ユーザー名を入力してください：" UserName
  read -p "パスワードを入力してください：" Password
  printf "%s,%s,%s\n" "$ServiceName" "$UserName" "$Password" >> ./apprentice
  echo "パスワードの追加は成功しました。"
  #\n次の選択肢から入力してください(Add Password/Get Password/Exit)：' Select
    ;;
    
  *"Get Password" )
  read -p "サービス名を入力してください：" LinkService
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
;;

*)
echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
;;
esac
done
