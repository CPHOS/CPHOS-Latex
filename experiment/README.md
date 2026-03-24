# CPHOS 实验命题模板

本文件夹包含 CPHOS 物理竞赛联考**实验试题**的 LaTeX 排版模板，用于生成试题、参考答案与答题卡。

## 目录
- [CPHOS 实验命题模板](#cphos-实验命题模板)
  - [目录](#目录)
  - [快速开始](#快速开始)
    - [设置 LaTeX 搜索路径](#设置-latex-搜索路径)
  - [文件结构](#文件结构)
  - [文档类选项](#文档类选项)
  - [核心环境](#核心环境)
    - [`problem` 环境](#problem-环境)
    - [`expcontent` 环境（仅 exam 模式）](#expcontent-环境仅-exam-模式)
    - [`expanswer` 环境（answer / answersheet 模式）](#expanswer-环境answer--answersheet-模式)
    - [实验题编号命令](#实验题编号命令)
    - [`examschedule` 环境（仅 exam 模式）](#examschedule-环境仅-exam-模式)
    - [`examnotes` 环境（仅 exam 模式）](#examnotes-环境仅-exam-模式)
  - [评分与分值检查](#评分与分值检查)
    - [得分点命令 `\spt`](#得分点命令-spt)
    - [分值检查开关](#分值检查开关)
  - [答题卡写法（answersheet）](#答题卡写法answersheet)
    - [留空行](#留空行)
    - [插入坐标纸](#插入坐标纸)
    - [插入与第三栏同宽表格](#插入与第三栏同宽表格)
  - [页眉页脚与标题](#页眉页脚与标题)
  - [水印设置](#水印设置)
  - [表格与图片建议](#表格与图片建议)
  - [联系方式与版权](#联系方式与版权)
  - [字体要求](#字体要求)

## 快速开始

### 设置 LaTeX 搜索路径

**方法一：设置 TEXINPUTS 环境变量**

通过终端临时设置环境变量：

**Windows PowerShell：**
```powershell
$env:TEXINPUTS = ".;path\to\CPHOS-Latex\experiment;$env:TEXINPUTS"
```

**Windows CMD：**
```cmd
set TEXINPUTS=.;path\to\CPHOS-Latex\experiment;%TEXINPUTS%
```

**Linux / macOS：**
```bash
export TEXINPUTS=".:path/to/CPHOS-Latex/experiment:$TEXINPUTS"
```

**方法二：安装到系统 TeX 目录**

将 `cphos-e.cls` 复制到本地 texmf 目录：

- **Windows (MiKTeX)**：`C:\Users\<用户名>\AppData\Local\MiKTeX\tex\latex\cphos\`
- **Linux/macOS (TeX Live)**：`~/texmf/tex/latex/cphos/`

安装后：
- MiKTeX：MiKTeX Console -> Tasks -> Refresh file name database
- TeX Live：运行 `texhash`

> [!TIP]
> 如果你使用 Tectonic 编译器，`TEXINPUTS` 可能不会生效。请用 `-Z search-path=...` 指定模板目录。

## 文件结构

```text
experiment/
├── cphos-e.cls          # 实验试题文档类
├── assets/              # 资源文件
├── examples/
│   ├── example-paper.tex # 示例文档（可切换 answer / exam / answersheet）
│   └── figs/            # 示例图片
└── README.md            # 本文档
```

## 文档类选项

```latex
\documentclass[选项]{cphos-e}
```

| 选项 | 说明 |
|------|------|
| `answer` | 参考答案模式（**默认**），显示 `expanswer` 内容，隐藏题干 |
| `exam` | 试题模式，显示 `expcontent`、`examschedule`、`examnotes`，隐藏 `expanswer` |
| `answersheet` | 答题卡模式，显示三栏答题区，第三栏显示答题卡内容 |
| `nowatermark` | 不显示背景水印 |

## 核心环境

### `problem` 环境

定义一道完整题目：

```latex
\begin{problem}[40]{弗兰克-赫兹实验}
  ...
\end{problem}
```

参数说明：
- 可选参数 `[总分]`：题目总分
- 必需参数 `{标题}`：题目标题

模式行为：
- `exam`：显示 `A.标题（40分）`
- `answer` / `answersheet`：不显示题目标题行，直接进入答案三栏区域

### `expcontent` 环境（仅 exam 模式）

题干区域，仅在 `exam` 模式显示：

```latex
\begin{expcontent}
题干、图表、数据表...
\end{expcontent}
```

在 `answer` / `answersheet` 中会自动隐藏。

### `expanswer` 环境（answer / answersheet 模式）

三栏区域（总宽约 18.98cm）：
- 第一栏：`A.1`（大问编号）及分值
- 第二栏：`A.1.1`（小问编号）及分值
- 第三栏：答案正文（`answer`）或答题卡内容（`answersheet`）

```latex
\begin{expanswer}
\anspart[26.0]
\ansq[2.0]{答案内容}{答题卡内容}
\anslastq[3.0]{答案内容}{答题卡内容}
\end{expanswer}
```

命令说明：
- `\anspart[分数]`：开始一个部分（对应 `\pmark`）
- `\ansq[分数]{answer内容}{answersheet内容}`：普通小问
- `\anslastq[分数]{answer内容}{answersheet内容}`：本部分最后一问（底部画实线）

### 实验题编号命令

用于题干区（通常放在 `expcontent` 里）：

| 命令 | 输出 | 说明 |
|------|------|------|
| `\pmark[26]{测定氩原子第一激发电位}` | `1.测定氩原子第一激发电位（26分）` | 部分标题 |
| `\subq` | `A.1.1` | 小问编号 |

说明：
- 当前模板固定三层结构：`A.` / `1.` / `A.1.1`
- 不支持 `\subsubq` 与 `\subsubsubq`，调用会报错

### `examschedule` 环境（仅 exam 模式）

时间安排区域，仅 `exam` 有效：

```latex
\begin{examschedule}
\begin{tabular}{cc}
  答题卡上传 & 阅卷 \\
  ...
\end{tabular}
\end{examschedule}
```

### `examnotes` 环境（仅 exam 模式）

考生须知列表，仅 `exam` 有效：

```latex
\begin{examnotes}
  \item 实验试题共 \textbf{\underline{\cphostotalpages}} 页...
  \item 试题满分 \textbf{\underline{\cphostotalscore}} 分。
\end{examnotes}
```

| 命令 | 说明 |
|------|------|
| `\cphostotalpages` | 总页数（需两次编译） |
| `\cphostotalscore` | 总分（仅 exam 模式累加，需两次编译） |

## 评分与分值检查

### 得分点命令 `\spt`

```latex
\spt{1.0}
\spt[Num = 3 - 2 - X]{0.5}
```

行为：
- `answer`：显示文字（若有）并记录分值
- `answersheet`：不输出内容（用于复用同一份源文件）

### 分值检查开关

```latex
\setscorecheck{true}   % 开启
\setscorecheck{false}  % 关闭（默认）
```

开启后会检查：
- `\spt` 分值和 `\ansq` 分值是否一致
- `\ansq` 分值和 `\anspart` 分值是否一致
- `\anspart` 分值和 `problem` 总分是否一致

## 答题卡写法（answersheet）

在 `answersheet` 模式下，`\ansq` / `\anslastq` 的第三参数会显示在第三栏。

### 留空行

```latex
\ansq[2.0]{答案}{\ansblank{2}}
```

`\ansblank{n}` 代表留 `n` 行高度空白。

### 插入坐标纸

```latex
\ansq[7.0]{答案}{
  \begin{minipage}[t]{\linewidth}
    \centering
    \includegraphics[width=0.9\linewidth]{figs/graphpaper.jpg}
  \end{minipage}
}
```

### 插入与第三栏同宽表格

建议用 `tabular`（不要在该单元格里再套 `tabularx`）：

```latex
\ansq[3.0]{答案}{
  \begin{tabular}{|>{\centering\arraybackslash}m{1.2cm}|*{5}{>{\centering\arraybackslash}m{2.8cm}|}}
    \hline
    元素 & Ar & Hg & Li & Mg & He \\\hline
    $U_0/\text{V}$ & & & & 3.18 & \\\hline
    $\lambda_0/\text{nm}$ & & & 670.8 & & 584.3 \\\hline
  \end{tabular}
}
```

## 页眉页脚与标题

```latex
\cphostitle{第XX届 CPHOS 物理竞赛联考}
\cphossubtitle{实验试题参考答案}
```

默认副标题：
- `answer`：实验试题参考答案
- `exam`：实验试题
- `answersheet`：实验答题卡

补充：
- `answersheet` 页眉中央自动显示 `姓名：`
- `answer` 与 `answersheet` 默认无页眉分割线

标题页命令：

```latex
\maketitlepage
```

- `answer` / `exam`：显示标题页
- `answersheet`：默认不显示标题页内容

## 水印设置

```latex
\cphoswatermark{../assets/watermark.jpg}
```

默认路径：`assets/watermark.jpg`。

## 表格与图片建议

- 跨页数据表：优先用 `tabularx`（模板已加载 `ltablex`）
- 在答题卡第三栏内嵌内容时：优先用 `\linewidth`，避免 `\textwidth`
- 不要在 `expanswer` 单元格内再嵌套 `tabularx`，可改用 `tabular` + 固定列宽

## 联系方式与版权

以下环境/命令仅在 `exam` 模式显示：

```latex
\begin{copyrightinfo}
  ...
  \contactinfo
\end{copyrightinfo}
```

## 字体要求

模板默认配置：
- 西文：Times New Roman
- 中文正文字体：SimSun
- 中文楷体：KaiTi（通过 `\kaiti` 调用）