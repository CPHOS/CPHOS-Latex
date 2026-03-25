%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Project: CPHOS LaTeX Template
%%  File: cphos.cls
%%  Copyright © 2026 gameswu & CPHOS (www.cphos.cn)
%%
%%  Permission is hereby granted, free of charge, to any person obtaining a 
%%  copy of this software and associated documentation files (the "Software"), 
%%  to deal in the Software without restriction, including without limitation 
%%  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
%%  and/or sell copies of the Software, and to permit persons to whom the 
%%  Software is furnished to do so, subject to the following conditions:
%%
%%  The above copyright notice and this permission notice shall be included 
%%  in all copies or substantial portions of the Software.
%%
%%  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
%%  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
%%  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
%%  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
%%  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
%%  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
%%  DEALINGS IN THE SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 用法: \documentclass[options]{cphos}
%
% 选项:
%   answer - 参考答案及评分标准模式（默认）
%   exam   - 试题模式
%   nowatermark - 不显示水印

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cphos}[2026/03/08 v1.0 CPHOS Physics Competition Document Class]

% === 选项处理 ===
\newif\ifcphos@answer
\newif\ifcphos@watermark
\cphos@answertrue      % 默认为答案模式
\cphos@watermarktrue   % 默认显示水印

\DeclareOption{answer}{\cphos@answertrue}
\DeclareOption{exam}{\cphos@answerfalse}
\DeclareOption{nowatermark}{\cphos@watermarkfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% 基于article类
\LoadClass[11pt, a4paper]{article}

% === 宏包加载 ===
\RequirePackage[UTF8]{ctex}        % 中文支持
\RequirePackage{amsmath, amssymb}  % 数学公式
\RequirePackage{geometry}          % 页边距设置
\RequirePackage{fancyhdr}          % 页眉页脚
\RequirePackage{enumitem}          % 列表格式自定义
\RequirePackage{titlesec}          % 标题格式修改
\RequirePackage{xcolor}            % 颜色支持
\RequirePackage{graphicx}          % 图片支持
\RequirePackage{fontspec}          % 字体设置（XeLaTeX）
\RequirePackage{lastpage}          % 总页数
\RequirePackage{siunitx}           % 科学计数法和单位
\RequirePackage{graphbox}          % 图片垂直对齐支持
\RequirePackage{eso-pic}           % 背景水印支持
\RequirePackage{tikz}              % TikZ绘图（用于水印透明度）
\RequirePackage{xparse}            % 高级命令定义
\RequirePackage{float}             % 图片位置控制
\RequirePackage{caption}           % 图片标题自定义
\RequirePackage{wrapfig}           % 文字环绕图片支持
\RequirePackage{subcaption}        % 子图支持
\RequirePackage[colorlinks=true, linkcolor=black, citecolor=black, urlcolor=cyan]{hyperref}  % 超链接支持（仅URL为亮蓝色）
\RequirePackage{upgreek}           % 直立希腊字母
\RequirePackage{bm}                % 粗体数学符号
\RequirePackage{comment}           % 条件注释支持

% === 字体设置 ===
\setmainfont{Times New Roman}
\setCJKmainfont[BoldFont=SimHei]{SimSun}  % 中文宋体，粗体用黑体
\setCJKfamilyfont{kai}[AutoFakeBold=2]{KaiTi}
\newcommand{\kaiti}{\CJKfamily{kai}}

% === 页面设置 ===
% 对应Word页边距: top≈2.34cm, bottom≈2.54cm, left=right≈3.17cm
\geometry{
    left=3.17cm, 
    right=3.17cm, 
    top=2.34cm, 
    bottom=2.54cm, 
    headheight=1.5cm, 
    headsep=0.5cm, 
    footskip=1cm
}
\linespread{1.0}

% === 段落缩进 ===
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}  % 段落间无额外间距

% === 页眉页脚变量 ===
\newcommand{\cphos@title}{CPHOS物理竞赛联考}
\newcommand{\cphos@subtitle}{理论试题参考答案及评分标准}

% 设置标题信息
\newcommand{\cphostitle}[1]{\renewcommand{\cphos@title}{#1}}
\newcommand{\cphossubtitle}[1]{\renewcommand{\cphos@subtitle}{#1}}

% === 编译时间 ===
% \compiletime 输出当前编译时间（格式：YYYY年M月D日HH:MM）
\newcommand{\compiletime}{%
    \the\year 年\the\month 月\the\day 日%
    \@tempcnta=\time
    \@tempcntb=\@tempcnta
    \divide\@tempcntb by 60
    \ifnum\@tempcntb<10 0\fi\the\@tempcntb:%
    \multiply\@tempcntb by 60
    \advance\@tempcnta by -\@tempcntb
    \ifnum\@tempcnta<10 0\fi\the\@tempcnta
}

% === 页眉页脚设置 ===
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\kaiti\small \cphos@title}
\fancyhead[R]{\kaiti\small \cphos@subtitle}
\fancyfoot[L]{\thepage\ / \pageref{LastPage}}
\fancyfoot[R]{\copyright\ \the\year\ CPHOS}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% 首页样式（无页眉）
\fancypagestyle{firstpage}{%
    \fancyhf{}
    \fancyfoot[L]{\thepage\ / \pageref{LastPage}}
    \fancyfoot[R]{\copyright\ \the\year\ CPHOS}
    \renewcommand{\headrulewidth}{0pt}
}

% === 水印设置 ===
\newcommand{\cphos@watermarkfile}{assets/watermark.jpg}
\newcommand{\cphoswatermark}[1]{\renewcommand{\cphos@watermarkfile}{#1}}

\ifcphos@watermark
    \AddToShipoutPictureFG{%  % 前景层：浮于图片之上，文字因高对比度视觉上仍居最前
        \AtPageCenter{%
            \begin{tikzpicture}[remember picture, overlay]
                \node[opacity=0.15] at (0,0) {%
                    \includegraphics[width=0.6\paperwidth,keepaspectratio]{\cphos@watermarkfile}%
                };
            \end{tikzpicture}%
        }%
    }
\fi

% === 标题格式 ===
\titleformat{\section}{\normalsize\bfseries}{}{0em}{}
\titlespacing{\section}{0pt}{1.5ex plus .1ex minus .2ex}{0.5ex plus .1ex}

% === 计数器定义 ===
\newcounter{problemnum}
\newcounter{subproblemnum}[problemnum]
\newcounter{subsubproblemnum}[subproblemnum]
\newcounter{eqnum}[problemnum]
\newcounter{totalscore}  % 总分累加器

% === 图片编号系统 ===
% 题干图片计数器和解答图片计数器
\newcounter{problemfignum}[problemnum]
\newcounter{solutionfignum}[problemnum]
\newif\ifcphos@insolution
\cphos@insolutionfalse

% 在figure/wrapfigure环境开始时递增正确的计数器
\RequirePackage{etoolbox}
\AtBeginEnvironment{figure}{%
    \ifcphos@insolution
        \refstepcounter{solutionfignum}%
    \else
        \refstepcounter{problemfignum}%
    \fi
}
\AtBeginEnvironment{wrapfigure}{%
    \ifcphos@insolution
        \refstepcounter{solutionfignum}%
    \else
        \refstepcounter{problemfignum}%
    \fi
}
\AtBeginEnvironment{wrapfigure*}{%
    \ifcphos@insolution
        \refstepcounter{solutionfignum}%
    \else
        \refstepcounter{problemfignum}%
    \fi
}

% 重定义figure编号格式
\renewcommand{\thefigure}{%
    \ifcphos@insolution
        \arabic{problemnum}.\arabic{solutionfignum}%
    \else
        \arabic{problemnum}.\arabic{problemfignum}%
    \fi
}

% 重定义figure的caption名称
\DeclareCaptionLabelFormat{problemfig}{图~#2}
\DeclareCaptionLabelFormat{solutionfig}{答图~#2}
\captionsetup[figure]{labelformat=problemfig}

% 子图编号格式：中文全角括号（a）（b）等
\renewcommand{\thesubfigure}{（\alph{subfigure}）}
\captionsetup[subfigure]{labelformat=simple, labelsep=space, font=small}

% 题号转中文
\newcommand{\chnnum}[1]{%
    \ifcase#1\or 一\or 二\or 三\or 四\or 五\or 六\or 七\or 八\or 九\or 十\fi
}

% === 题目环境 ===
% \begin{problem}[总分]{标题}...\end{problem}
% 总分为可选参数，标题为必需参数（可以为空字符串）
\newcommand{\cphos@problem@score}{}
\newenvironment{problem}[2][]{%
    \def\cphos@problem@score{#1}%
    \refstepcounter{problemnum}%
    % 仅在exam模式下累加总分
    \ifcphos@answer\else
        \ifx\cphos@problem@score\@empty\else
            \addtocounter{totalscore}{#1}%
        \fi
    \fi
    % 设置当前题目总分供scoring使用
    \setproblemscore{#1}%
    \setcounter{subproblemnum}{0}%
    \setcounter{eqnum}{0}%
    \setcounter{problemfignum}{0}%
    \setcounter{solutionfignum}{0}%
    \cphos@insolutionfalse%
    \captionsetup[figure]{labelformat=problemfig}%
    \clearScores
    \vspace{1em}%
    % 根据参数情况渲染标题
    \noindent{\bfseries \chnnum{\value{problemnum}}%
        \ifx\cphos@problem@score\@empty\else、（#1分）\fi%
        #2}%
    \par%
}{%
    \par%
}

% === 题干环境 ===
\newenvironment{problemstatement}{%
    \setlength{\parindent}{2em}%
}{%
    \par\vspace{\baselineskip}%  % 题干后空一行
}

% === 解答环境 ===
% exam模式下隐藏解答内容，answer模式下显示
\ifcphos@answer
    \newenvironment{solution}{%
        \cphos@insolutiontrue%
        \captionsetup[figure]{labelformat=solutionfig}%
        \noindent{\bfseries 解：}%
        \par%
        \setlength{\parindent}{0pt}%
    }{%
        \cphos@insolutionfalse%
        \captionsetup[figure]{labelformat=problemfig}%
        \par%
    }
\else
    % exam模式：完全隐藏solution内容
    \excludecomment{solution}
\fi

% === 小问编号命令（题干用） ===
\newcommand{\pmark}[1]{%
    \noindent\textbf{Part~#1}%
}
\newcommand{\subq}[1]{%
    \noindent（#1）%
}
\newcommand{\subsubq}[1]{%
    \noindent（#1）%
}
\newcommand{\subsubsubq}[1]{%
    \noindent（#1）%
}

% === 解答中的小问编号命令（自动记分） ===
% \solPart{A}{分值} -> Part A 并记录\scorePart
% \solsubq{1}{分值} -> （1）并记录\scorepart
\newcommand{\solPart}[2]{%
    \scorePart{#1}{#2}%
    \noindent\textbf{Part~#1}%
}
\newcommand{\solsubq}[2]{%
    \scorepart{#1}{#2}%
    \noindent（#1）%
}
\newcommand{\solsubsubq}[2]{%
    \scoresubpart{#1}{#2}%
    \noindent（#1）%
}
\newcommand{\solsubsubsubq}[2]{%
    \scoresubsubpart{#1}{#2}%
    \noindent（#1）%
}

% === 手动评分标准 ===
\newcommand{\scoringmanual}[1]{%
    \par\noindent{\bfseries 评分标准：#1}%
}

% === 多解法环境 ===
% 用法：\begin{multisol}[前缀] \item 解法一正文 \item 解法二正文 \end{multisol}
% 前缀默认"解法"，\item 自动生成标签"（解法一）""（解法二）"等
% 评分标准中各解法式子自动合并展示，并在启用分值检查时验证各解法总分是否相等
\newcounter{cphos@msolitem}
\NewDocumentEnvironment{multisol}{O{解法}}{%
    \setcounter{cphos@msolitem}{0}%
    \cphosmsolstart{#1}%
    \renewcommand{\item}{%
        \stepcounter{cphos@msolitem}%
        \cphosmsolitem%
        \par\noindent（#1\chnnum{\value{cphos@msolitem}}）\enspace%
    }%
}{%
    \cphosmsolend%
    \par%
}

% === 参考文献环境 ===
% 用于在解答之后、评分标准之前展示参考文献
% 中文楷体，西文Times New Roman，五号字体
\newcounter{problemrefnum}[problemnum]
\newenvironment{problemreferences}[1][]{%
    \par\vspace{\baselineskip}%  % 参考文献前空一行
    \noindent{\kaiti 本题的参考文献：}%
    \par%
    \setlength{\parindent}{2em}%  % 段首缩进
    {\kaiti\fontsize{10.5pt}{15.75pt}\selectfont #1}%
    \setcounter{problemrefnum}{0}%
    \par%
    \kaiti\fontsize{10.5pt}{12.6pt}\selectfont%  % 参考文献条目使用较紧凑的行距
}{%
    \par%
}

% 参考文献条目命令
\newcommand{\refitem}[1]{%
    \refstepcounter{problemrefnum}%
    \par\noindent\hangindent=1.5em\hangafter=1[\arabic{problemrefnum}]~#1%
}

% 上标引用命令
\newcommand{\supercite}[1]{\textsuperscript{#1}}

% === 题目附录环境 ===
% 用于在评分标准之后展示附加内容，楷体，方框框定，支持分页
\RequirePackage{mdframed}  % 支持分页的方框
\newenvironment{problemappendix}[1][{\kaiti 附录}]{%
    \begin{mdframed}[linewidth=0.5pt, innertopmargin=0.5em, innerbottommargin=0.5em]%
    \noindent{\bfseries #1}\par%
    \kaiti%
}{%
    \end{mdframed}%
}

% === 标题页命令 ===
\newcommand{\maketitlepage}{%
    \thispagestyle{firstpage}%
    \begin{center}
        {\fontsize{16pt}{24pt}\selectfont\bfseries \cphos@title} \\[0.3em]
        {\fontsize{14pt}{21pt}\selectfont\bfseries \cphos@subtitle}
    \end{center}
}

% === 时间安排环境（仅exam模式显示）===
% 使用：\begin{examschedule} 表格内容 \end{examschedule}
\ifcphos@answer
    % answer模式下隐藏
    \excludecomment{examschedule}
\else
    \newenvironment{examschedule}{%
        \par%
        \begin{center}
        \kaiti\fontsize{9pt}{13.5pt}\selectfont%  % 小五号楷体
    }{%
        \end{center}
        \par%
    }
\fi

% === 考生须知辅助命令 ===
% \cphostotalscore - 输出试题总分值（需要两次编译）
% \cphostotalpages - 输出试卷总页数（需要两次编译）
\def\cphos@saved@totalscore{??}
\def\cphos@saved@totalpages{??}
\newcommand{\cphostotalscore}{\cphos@saved@totalscore}
\newcommand{\cphostotalpages}{\cphos@saved@totalpages}
% 在文档末尾记录总分和总页数
\AtEndDocument{%
    \immediate\write\@auxout{%
        \string\gdef\string\cphos@saved@totalscore{\arabic{totalscore}}%
    }%
    \immediate\write\@auxout{%
        \string\gdef\string\cphos@saved@totalpages{\thepage}%
    }%
}

% === 考生须知环境（仅exam模式显示）===
% 使用：\begin{examnotes} \item 内容 \end{examnotes}
\ifcphos@answer
    % answer模式下隐藏
    \excludecomment{examnotes}
\else
    \newenvironment{examnotes}{%
        \par%
        \begin{center}
            {\fontsize{10.5pt}{15.75pt}\selectfont\bfseries 考生须知}
        \end{center}
        \vspace{-0.5em}%
        \kaiti\fontsize{10.5pt}{15.75pt}\selectfont%  % 五号楷体
        \begin{enumerate}[leftmargin=2em, labelsep=0.5em, itemsep=0pt, parsep=0pt]
    }{%
        \end{enumerate}
        \par%
    }
\fi

% === 版权信息环境（不分页）===
% 使用minipage确保内容在同一页
\newenvironment{copyrightinfo}{%
    \par\vspace{2em}%
    \noindent\begin{minipage}{\textwidth}%
}{%
    \end{minipage}%
    \par%
}

% === 联系方式表格命令 ===
\newcommand{\contactinfo}{%
    \begin{center}
        {\bfseries 联系方式}
    \end{center}
    \vspace{0.5em}
    \noindent
    \begin{tabular}{@{}c@{\quad}c@{\quad}c@{\quad}p{4cm}@{}}
        \includegraphics[width=2.9cm, align=c]{../assets/fig1.jpg} &
        \includegraphics[width=2.9cm, align=c]{../assets/fig2.png} &
        \includegraphics[width=2.9cm, align=c]{../assets/fig3.png} &
        \begin{tabular}[c]{@{}c@{}}
            {\small 邮箱} \\
            {\small \url{service@cphos.cn}} \\
            {\small 微信小程序} \\
            {\small CPHOS物理竞赛联考}
        \end{tabular} \\[-0.3em]
        
        {\small 微信公众号} & {\small 官方网站} & {\small CPHOS论坛} & \\
        {\small CPHOS} & {\small \url{www.cphos.cn}} & & \\
    \end{tabular}
}

% 加载评分系统
\RequirePackage{cphos-scoring}

\endinput
