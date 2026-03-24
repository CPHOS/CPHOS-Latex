# CPHOS 理论命题模板

本文件夹包含 CPHOS 物理竞赛联考**理论试题**的 LaTeX 排版模板，用于命题、制作参考答案及评分标准。

## 目录
- [CPHOS 理论命题模板](#cphos-理论命题模板)
  - [目录](#目录)
  - [快速开始](#快速开始)
    - [设置 LaTeX 搜索路径](#设置-latex-搜索路径)
  - [文件结构](#文件结构)
  - [文档类选项](#文档类选项)
  - [核心环境](#核心环境)
    - [`problem` 环境](#problem-环境)
    - [`problemstatement` 环境](#problemstatement-环境)
    - [`solution` 环境](#solution-环境)
    - [`examschedule` 环境（仅 exam 模式）](#examschedule-环境仅-exam-模式)
    - [`examnotes` 环境（仅 exam 模式）](#examnotes-环境仅-exam-模式)
    - [小问编号命令（题干用）](#小问编号命令题干用)
    - [小问编号命令（解答用，自动记分）](#小问编号命令解答用自动记分)
  - [评分标准系统](#评分标准系统)
    - [层级声明命令（手动方式）](#层级声明命令手动方式)
    - [计分命令](#计分命令)
    - [多解法环境 `multisol`](#多解法环境-multisol)
    - [自动生成评分标准](#自动生成评分标准)
    - [分值检查](#分值检查)
  - [页眉页脚设置](#页眉页脚设置)
    - [水印设置](#水印设置)
  - [图片编号系统](#图片编号系统)
  - [参考文献环境](#参考文献环境)
  - [附录环境](#附录环境)
  - [联系方式与版权](#联系方式与版权)
  - [答题卡模板](#答题卡模板)
  - [阅卷指南模板](#阅卷指南模板)
  - [试题评析模板](#试题评析模板)
  - [其他命令](#其他命令)
  - [字体要求](#字体要求)

## 快速开始

### 设置 LaTeX 搜索路径

**方法一：设置 TEXINPUTS 环境变量**

设置环境变量后，LaTeX 会自动搜索指定目录中的 `.cls` 和 `.sty` 文件。

通过终端临时设置环境变量：

**Windows PowerShell：**
```powershell
$env:TEXINPUTS = ".;path\to\CPHOS-Latex\theory;$env:TEXINPUTS"
```

**Windows CMD：**
```cmd
set TEXINPUTS=.;path\to\CPHOS-Latex\theory;%TEXINPUTS%
```

**Linux / macOS：**
```bash
export TEXINPUTS=".:path/to/CPHOS-Latex/theory:$TEXINPUTS"
```

或者通过设置系统环境变量永久生效。

**方法二：安装到系统 TeX 目录**

将 `cphos.cls` 和 `cphos-scoring.sty` 复制到本地 texmf 目录：

- **Windows (MiKTeX)**：`C:\Users\<用户名>\AppData\Local\MiKTeX\tex\latex\cphos\`
- **Linux/macOS (TeX Live)**：`~/texmf/tex/latex/cphos/`

安装后：
- MiKTeX：打开 MiKTeX Console → Tasks → Refresh file name database
- TeX Live：运行 `texhash`

> [!TIP]
> 如果你使用 Tectonic 编译器，`TEXINPUTS` 环境变量不会生效。请使用 `-Z search-path=\path\to\CPHOS-Latex\theory` 选项指定模板路径，详情参考 [Tectonic 文档](https://tectonic-typesetting.github.io/book/latest/v2cli/compile.html)。

## 文件结构

```
theory/
├── cphos.cls           # 理论试题文档类
├── cphos-scoring.sty   # 评分系统宏包
├── assets/             # 资源文件
│   ├── watermark.jpg   # 水印图片
│   ├── fig1.jpg        # 联系方式二维码
│   ├── fig2.png
│   └── fig3.png
├── examples/           # 示例文件
│   ├── example-problem.tex    # 命题模板
│   ├── example-paper.tex      # 完整试卷
│   ├── example-answersheet.tex # 答题卡
│   └── fig/            # 示例图片
└── README.md           # 本文档
```

## 文档类选项

```latex
\documentclass[选项]{cphos}
```

| 选项 | 说明 |
|------|------|
| `answer` | 参考答案及评分标准模式（**默认**），显示完整解答 |
| `exam` | 试题模式，隐藏 `solution`、显示 `examschedule` 和 `examnotes` |
| `nowatermark` | 不显示背景水印 |

## 核心环境

### `problem` 环境

定义一道完整的题目（题号自动生成）：

```latex
\begin{problem}[25]{电磁感应}
    \begin{problemstatement}
        题干内容...
    \end{problemstatement}
    
    \begin{solution}
        解答内容...
        \scoring
    \end{solution}
\end{problem}
```

**参数说明：**
- 可选参数 `[总分]`：题目总分值，省略则不显示分值，也不纳入总分累加
- 必需参数 `{标题}`：题目标题，可以为空字符串

**示例：**
```latex
\begin{problem}[40]{太阳物理初步}  % 40分，有标题
\begin{problem}[25]{}              % 25分，无标题
\begin{problem}{电磁感应}          % 不声明总分
```

### `problemstatement` 环境

题干区域，自动设置首行缩进。

### `solution` 环境

解答区域，在 `exam` 模式下自动隐藏。

### `examschedule` 环境（仅 exam 模式）

时间安排表格区域，使用楷体小五号字体，仅在 `exam` 模式下显示：

```latex
\begin{examschedule}
\begin{tabular}{cc}
    答题卡上传 & 阅卷 \\
    2025/10/11 12:00 - 2025/10/14 18:00 & 2025/10/15 08:00 - 2025/10/18 20:00 \\
\end{tabular}
\end{examschedule}
```

### `examnotes` 环境（仅 exam 模式）

考生须知列表，标题使用宋体五号粗体，内容使用楷体五号，仅在 `exam` 模式下显示。

可使用 `\cphostotalpages` 和 `\cphostotalscore` 自动填充页数和总分（需要两次编译）：

```latex
\begin{examnotes}
    \item 理论试题共 \textbf{\underline{\cphostotalpages}} 页，理论答题卡共 \textbf{\underline{X}} 页，答题时间 \textbf{\underline{180}} 分钟，试题满分 \textbf{\underline{\cphostotalscore}} 分。
    \item 请在答题卡的指定答题区域内答题，试题和草稿纸上的内容将不会作为评分参考，不可申请答题卡加页。
    \item 若发现试题存在问题，请向领队（教练）反映，由其转达至相关微信群聊。
\end{examnotes}
```

| 命令 | 说明 |
|------|------|
| `\cphostotalpages` | 试卷总页数（仅 exam 模式有效，需两次编译） |
| `\cphostotalscore` | 试题总分值（仅 exam 模式累加，需两次编译） |

### 小问编号命令（题干用）

所有小问命令均不自动换行，如需换行请在命令前手动空行。

| 命令 | 输出 | 说明 |
|------|------|------|
| `\pmark{A}` | **Part A** | Part 级别标题 |
| `\subq{1}` | （1） | 一级小问 |
| `\subsubq{i}` | （i） | 二级小问 |
| `\subsubsubq{a}` | （a） | 三级小问 |

### 小问编号命令（解答用，自动记分）

在解答中使用，自动调用对应的 `\scorepart` 等命令记录分值：

| 命令 | 用途 |
|------|------|
| `\solPart{A}{10}` | 输出 **Part A** 并记录 Part A 共 10 分 |
| `\solsubq{1}{8}` | 输出 （1） 并记录第（1）问共 8 分 |
| `\solsubsubq{i}{4}` | 输出 （i） 并记录第（i）子问共 4 分 |
| `\solsubsubsubq{a}{2}` | 输出 （a） 并记录第（a）子子问共 2 分 |

## 评分标准系统

### 层级声明命令（手动方式）

在解答中声明各部分分值：

| 命令 | 用途 |
|------|------|
| `\scorePart{A}{10}` | 声明 Part A 共 10 分 |
| `\scorepart{1}{8}` | 声明第（1）问共 8 分 |
| `\scoresubpart{i}{4}` | 声明第（i）子问共 4 分 |
| `\scoresubsubpart{a}{2}` | 声明第（a）子子问共 2 分 |

### 计分命令

| 命令 | 用途 |
|------|------|
| `\eqtagscore{编号}{分值}` | 公式编号并计分 |
| `\eqtag{编号}` | 仅公式编号，不计分 |
| `\addtext{描述}{分值}` | 文字描述计分 |

### 多解法环境 `multisol`

当一道题有多种不同解法时，使用 `multisol` 环境分别列出各解法：

```latex
\begin{multisol}[可选前缀]
\item  % 输出「（解法一）」，解法一正常使用 \eqtagscore 计分
    \begin{equation}
        F = ma \eqtagscore{1}{6}
    \end{equation}
    \begin{equation}
        E = mc^2 \eqtagscore{2}{9}
    \end{equation}
\item  % 输出「（解法二）」，建议在编号后加 * 以示区分
    \begin{equation}
        p = mv \eqtagscore{1*}{6}
    \end{equation}
    \begin{equation}
        \oint \vec{B} \cdot \mathrm{d}\vec{l} = \mu_0 I \eqtagscore{2*}{9}
    \end{equation}
\end{multisol}
```

**参数说明：**
- 可选参数为前缀名称，默认为 `解法`，生成"（解法一）""（解法二）"等标题
- 每个 `\item` 开启一条新解法
- 各解法内使用 `\eqtagscore`、`\addtext` 等命令正常标记分值；建议对第二条及以后解法的公式编号加 `*` 后缀以示区分

**分值计算规则：**
- 第一条解法的分值正常累加至题目总分
- 后续解法仅在评分标准中展示，不重复累加
- 各解法的总分应当相同；启用 `\setscorecheck{true}` 时，若各解法总分不一致，将在编译输出中产生红色警告

**自定义前缀示例：**

```latex
\begin{multisol}[方法]  % 生成「（方法一）」「（方法二）」等
    ...
\end{multisol}
```

### 自动生成评分标准

```latex
\scoring  % 自动汇总生成评分标准段落，总分从 problem 环境的可选参数获取
```

`\scoring` 不需要参数，自动使用 `problem` 环境中声明的总分。如果总分未声明或不是有效数值，在启用分值检查时会显示警告。

### 分值检查

```latex
\setscorecheck{true}   % 开启分值检查（默认关闭）
\setscorecheck{false}  % 关闭分值检查
```

分值检查仅在 `answer` 模式下生效，检查内容包括：
- 各小问声明分值与题目总分是否一致
- 子层级声明分值与父层级声明是否一致
- 总分是否为有效数值
- `multisol` 环境中各解法总分是否一致

## 页眉页脚设置

```latex
\cphostitle{第XX届CPHOS物理竞赛联考}
\cphossubtitle{理论试题参考答案及评分标准}
```

### 水印设置

```latex
\cphoswatermark{../assets/watermark.jpg}
```

默认路径为 `assets/watermark.jpg`，透明度 15%。

## 图片编号系统

模板自动区分题干与解答的图片编号：

| 位置 | 编号格式 |
|------|----------|
| `problemstatement` 内 | 图 X.Y |
| `solution` 内 | 答图 X.Y |

## 参考文献环境

```latex
\begin{problemreferences}[简短说明]
    \refitem{作者. 《书名》. 出版社, 年份.}
    \refitem{作者. 论文标题. 期刊, 卷(期): 页码, 年份.}
\end{problemreferences}
```

上标引用：`\supercite{1}` → ^[1]^

## 附录环境

```latex
\begin{problemappendix}[附录标题]
    附录内容...
\end{problemappendix}
```

支持跨页，带边框显示。

## 联系方式与版权

```latex
\begin{copyrightinfo}
    \contactinfo
\end{copyrightinfo}
```

## 答题卡模板

答题卡使用独立模板 `example-answersheet.tex`，不依赖 cphos.cls。

主要命令：

| 命令 | 用途 |
|------|------|
| `\answersheettitle{标题}` | 页眉左侧标题 |
| `\answersheetsubtitle{副标题}` | 页眉右侧副标题 |
| `\answerpagebox{题号}` | 新建一页并绘制边框 |

## 阅卷指南模板

阅卷指南基于 `cphos.cls` 模板，增加以下命令：
| 命令 | 用途 |
|------|------|
| `\gdproblem` | 输出"第N题："左对齐粗体标题，自动递增计数（题间有间隔，标题与正文无间隔） |

示例模板位于 `examples/example-guide.tex`。

## 试题评析模板

试题评析基于 `cphos.cls` 模板，增加以下命令：
| 命令 | 用途 |
|------|------|
| `\fbproblem` | 输出"第N题"中心对齐粗体标题，自动递增计数（题间有间隔，标题与正文无间隔） |
| `\fbsection{标题}`| 输出"标题"中心对齐粗体标题 |

示例模板位于 `examples/example-feedback.tex`。

## 其他命令

| 命令 | 用途 |
|------|------|
| `\compiletime` | 输出编译时间（格式：2026年3月9日14:30） |
| `\kaiti` | 切换楷体 |
| `\chnnum{3}` | 数字转中文（输出：三） |
| `\maketitlepage` | 生成标题页 |
| `\cphostotalscore` | 试题总分值（需两次编译） |
| `\cphostotalpages` | 试卷总页数（需两次编译） |

## 字体要求

确保系统安装以下字体：
- Times New Roman
- SimSun（宋体）
- SimHei（黑体）
- KaiTi（楷体）

你可以在 `assets` 文件夹中找到这些字体的安装包。