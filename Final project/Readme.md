# DSP 音高偵測專案（MATLAB）

## 專案簡介
本專案利用 **數位訊號處理（Digital Signal Processing, DSP）** 技術，分析 `.wav` 音訊訊號，辨識其對應的音符（C4 ~ C5），並判斷音準狀態。

系統可將輸入訊號分類為：
- ✅ Match（音準正確）
- ⚠️ Detuned（音準偏移）
- ❌ Out-of-range（超出範圍）
---
## 專案目標
- 將音訊訊號由時間域轉換至頻率域
- 找出訊號的主頻率（Fundamental Frequency）
- 利用濾波器分析各音符能量
- 判斷最接近的音符
- 評估音準準確性
---
## 系統流程
1. 音訊讀取（Audio Input）
2. 視窗處理（Windowing）
3. 頻率分析（FFT）
4. 濾波器組（Filter Bank）
5. 能量計算（Energy Detection）
6. 音符判斷（Classification）
7. 結果輸出（Table + Visualization）
---
## 🧠 DSP 核心概念說明
本專案涵蓋多個重要的數位訊號處理技術，以下為核心概念解析：
### 🔹 FFT（快速傅立葉轉換）
- 時間域 → 頻率域  
- 找出主頻率（Fundamental Frequency）
---
### 🔹 頻譜洩漏（Spectral Leakage）
- 使用 Hamming Window 降低頻譜誤差  
---
### 🔹 濾波器設計（Filter Design）
- 使用 `iirpeak` 建立帶通濾波器（Bandpass Filter）  
---
### 🔹 Q Factor（品質因數）
- 控制濾波器選擇性（頻寬）  
---
### 🔹 能量分析（Energy Detection）
- 使用：
  ```matlab
  sum(yy.^2)
## 📊 專案成果

- 成功辨識音符（C4 ~ C5）  
- 可判斷音準偏差（Detuned）  
- 提供能量分佈圖（Visualization）  
- 輸出分析結果表格（Table）  
