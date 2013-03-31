食べられるキノコはどれだ？
https://codeiq.jp/ace/naoyat/q140
http://next.rikunabi.com/tech/docs/ct_s03600.jsp?p=002315&tcs=kanren

Training data: "CodeIQ_data.txt"
  Length1[cm]: 柄の長さ
  Length2[cm]: 傘の直径 
  Safe:        o/x -> 可食/毒

Predict data: "CodeIQ_eaten.txt"
  Length1[cm]: 柄の長さ
  Length2[cm]: 傘の直径 

checker.R
  SVMで真贋を分類。
  実行にはggplot2 (グラフ)、kernlab (SVM)パッケージのインストールが必要。
  全3回の試行。
　  1. RBFカーネルでデフォルトパラメータ
      不正解がいくつかある。
    2. パラメータの調整
      まだ1つが不正解。
    3. Length1 = 11, Length2 = 11, "o" を正解データセットに追加
      すべて正解。

result.csv
  分類結果
