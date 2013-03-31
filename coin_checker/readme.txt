金貨の真贋を見分けよう
https://codeiq.jp/ace/naoyat/q105
http://next.rikunabi.com/tech/docs/ct_s03600.jsp?p=002315&tcs=kanren

Training data: "CodeIQ_auth.txt"
  Volume[/cm^3], Weight[g], Truth 0:偽 1:本物

Predict data: "CodeIQ_mycoins.txt"
  Volume[/cm^3], Weight[g]

checker.R
  SVMで真贋を分類。
  実行にはggplot2 (グラフ)、kernlab (SVM)パッケージのインストールが必要。

result.csv
  分類結果
