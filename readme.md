
# New Timeline with Crop

DaVinci Resolve 用のスクリプトです。
`New Timeline With Crop.lua` を `C:\ProgramData\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Edit` あたりに入れると、ワークスペースメニューのスクリプトに出てきます。

適用中のクロップ設定でクリップを切り出して新しいタイムラインを作成します。  
対象タイムラインの「プロジェクト設定を使用」がオンだと動かないためオフにしておく必要があります（ここをスクリプトから強制的に変更すると意図しない解像度になることがあるので、事前に手動で設定してください）。対象タイムライン内に複数のクリップが含まれる場合や、クリップがズームや移動されていると望んだ結果にならないと思います。  
タイムラインの解像度は偶数になるためクロップした内容と差異が発生することがあります。

