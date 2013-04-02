金塊か、キノコ料理か
https://codeiq.jp/ace/naoyat/q207
http://next.rikunabi.com/tech/docs/ct_s03600.jsp?p=002259&tcs=kanren

Data: "hundred.txt"
  Weight [g]
  Specific heat capacity [J/kg・K]
  Reflectivity [％]

one_class_svm.R
  1-class SVMで外れ値を判定。
  実行にはscatterplot3d (グラフ)、kernlab (SVM)パッケージが必要。
  上位5件を出力。
  結果は毎回変わる。

lof.R
  LOF(Local Outlier Factor)で外れ値を判定。
  実行にはscatterplot3dとDMwR (LOF)パッケージが必要。
  上位3件を出力。
  結果はほぼ一定。

kmeans.R
  k-means法でクラスタリング。
  実行にはscatterplot3dパッケージが必要。
  外れ値のみの分離が不可能だったので、
  各クラスタの中心から遠いもの上位5件を外れ値とみなした。

result_svm.csv
  one_class_svm.Rの上位5件の結果。

result_lof.csv
  lof.Rの上位3件の結果。

result_kmeans.csv
  kmeans.Rの上位5件の結果。
