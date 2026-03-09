%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Project: CPHOS LaTeX Template
%%  File: cphos-e.cls
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


% 用法: \documentclass[options]{cphos-e}
%
% 选项:
%   answer      - 参考答案模式（默认）
%   exam        - 试题模式
%   answersheet - 答题卡模式
%   nowatermark - 不显示水印

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cphos-e}[2026/03/09 v2.0 CPHOS Experimental Document Class]

% === 选项处理 ===
\newif\ifcphos@answer
\newif\ifcphos@exam
\newif\ifcphos@answersheet
\newif\ifcphos@watermark

\cphos@answertrue
\cphos@examfalse
\cphos@answersheetfalse
\cphos@watermarktrue

\DeclareOption{answer}{%
    \cphos@answertrue
    \cphos@examfalse
    \cphos@answersheetfalse
}
\DeclareOption{exam}{%
    \cphos@answerfalse
    \cphos@examtrue
    \cphos@answersheetfalse
}
\DeclareOption{answersheet}{%
    \cphos@answerfalse
    \cphos@examfalse
    \cphos@answersheettrue
}
\DeclareOption{nowatermark}{\cphos@watermarkfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt, a4paper]{article}

% === 宏包加载 ===
\RequirePackage[UTF8]{ctex}
\RequirePackage{amsmath, amssymb}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{fontspec}
\RequirePackage{lastpage}
\RequirePackage{siunitx}
\RequirePackage{graphbox}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\RequirePackage{xparse}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage[colorlinks=true, linkcolor=black, citecolor=black, urlcolor=cyan]{hyperref}
\RequirePackage{upgreek}
\RequirePackage{bm}
\RequirePackage{comment}

% === 字体设置 ===
\setmainfont{Times New Roman}
\setCJKmainfont[BoldFont=SimHei]{SimSun}
\setCJKfamilyfont{kai}{KaiTi}
\newcommand{\kaiti}{\CJKfamily{kai}}

% === 页面设置 ===
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
\setlength{\parskip}{0pt}

% === 页眉页脚变量 ===
\newcommand{\cphos@title}{CPHOS物理竞赛联考}
\newcommand{\cphos@subtitle}{实验试题参考答案}

\ifcphos@exam
    \renewcommand{\cphos@subtitle}{实验试题}
\fi
\ifcphos@answersheet
    \renewcommand{\cphos@subtitle}{实验答题卡}
\fi

\newcommand{\cphostitle}[1]{\renewcommand{\cphos@title}{#1}}
\newcommand{\cphossubtitle}[1]{\renewcommand{\cphos@subtitle}{#1}}

% === 编译时间 ===
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
    \AddToShipoutPictureBG{%
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

% === 计数器 ===
\newcounter{problemnum}
\newcounter{totalscore}

% 固定三层编号: B. / 1. / B.1.1
\newcounter{expPart}[problemnum]
\newcounter{expQ}[expPart]

% === 题号转中文 ===
\newcommand{\chnnum}[1]{%
    \ifcase#1\or 一\or 二\or 三\or 四\or 五\or 六\or 七\or 八\or 九\or 十\fi
}

% === 题目环境 ===
% \begin{problem}[总分]{标题}...
\newcommand{\cphos@problem@score}{}
\newenvironment{problem}[2][]{%
    \def\cphos@problem@score{#1}%
    \refstepcounter{problemnum}%
    \ifcphos@exam
        \ifx\cphos@problem@score\@empty\else
            \addtocounter{totalscore}{#1}%
        \fi
    \fi
    \setcounter{expPart}{0}%
    \setcounter{expQ}{0}%
    \vspace{1em}%
    \begin{center}
        \fontsize{12pt}{15pt}\selectfont
        {\bfseries \Alph{problemnum}.#2%
            \ifx\cphos@problem@score\@empty\else（#1分）\fi}%
    \end{center}%
}{%
    \par%
}

% === 实验正文环境（替代理论版problemstatement） ===
\newenvironment{expcontent}{%
    \setlength{\parindent}{2em}%
}{%
    \par\vspace{\baselineskip}%
}

% === 实验答案环境（answer模式显示，exam模式隐藏） ===
\ifcphos@answer
    \newenvironment{expanswer}{%
        \noindent{\bfseries 实验解答与评分说明：}%
        \par%
        \setlength{\parindent}{0pt}%
    }{%
        \par%
    }
\else
    \excludecomment{expanswer}
\fi

% === 实验三层编号命令 ===
% \pmark[分值]{标题} -> 1.理论分析（10分）
% \subq              -> B.1.1（仅生成编号，题干作为正文书写）
\NewDocumentCommand{\pmark}{o m}{%
    \refstepcounter{expPart}%
    \setcounter{expQ}{0}%
    \par\noindent\textbf{\arabic{expPart}.#2%
        \IfValueT{#1}{（#1分）}}%
}
\newcommand{\subq}{%
    \refstepcounter{expQ}%
    \par\noindent\textbf{\Alph{problemnum}.\arabic{expPart}.\arabic{expQ}}~%
}

% 强制禁止第三层以下
\newcommand{\subsubq}[1]{%
    \PackageError{cphos-e}{Only three levels are allowed: B., 1., B.1.1}{Please remove \string\subsubq.}
}
\newcommand{\subsubsubq}[1]{%
    \PackageError{cphos-e}{Only three levels are allowed: B., 1., B.1.1}{Please remove \string\subsubsubq.}
}

% === 标题页命令 ===
\newcommand{\maketitlepage}{%
    \thispagestyle{firstpage}%
    \begin{center}
        {\fontsize{16pt}{24pt}\selectfont\bfseries \cphos@title} \\[0.3em]
        {\fontsize{14pt}{21pt}\selectfont\bfseries \cphos@subtitle}
    \end{center}
}

% === 时间安排环境（仅exam模式显示） ===
\ifcphos@exam
    \newenvironment{examschedule}{%
        \par%
        \begin{center}
        \kaiti\fontsize{9pt}{13.5pt}\selectfont%
    }{%
        \end{center}
        \par%
    }
\else
    \excludecomment{examschedule}
\fi

% === 考生须知辅助命令（仅exam模式累加有效） ===
\def\cphos@saved@totalscore{??}
\def\cphos@saved@totalpages{??}
\newcommand{\cphostotalscore}{\cphos@saved@totalscore}
\newcommand{\cphostotalpages}{\cphos@saved@totalpages}
\AtEndDocument{%
    \immediate\write\@auxout{%
        \string\gdef\string\cphos@saved@totalscore{\arabic{totalscore}}%
    }%
    \immediate\write\@auxout{%
        \string\gdef\string\cphos@saved@totalpages{\thepage}%
    }%
}

% === 考生须知环境（仅exam模式显示） ===
\ifcphos@exam
    \newenvironment{examnotes}{%
        \par%
        \begin{center}
            {\fontsize{10.5pt}{15.75pt}\selectfont\bfseries 考生须知}
        \end{center}
        \vspace{-0.5em}%
        \kaiti\fontsize{10.5pt}{15.75pt}\selectfont%
        \begin{enumerate}[leftmargin=2em, labelsep=0.5em, itemsep=0pt, parsep=0pt]
    }{%
        \end{enumerate}
        \par%
    }
\else
    \excludecomment{examnotes}
\fi

% === 版权信息环境（不分页） ===
\newenvironment{copyrightinfo}{%
    \par\vspace{2em}%
    \noindent\begin{minipage}{\textwidth}%
}{%
    \end{minipage}%
    \par%
}

% === 联系方式 ===
\newcommand{\contactinfo}[5]{%
    \begin{center}
        {\bfseries 联系方式}
    \end{center}
    \vspace{0.5em}
    \noindent
    \begin{tabular}{@{}c@{\quad}c@{\quad}c@{\quad}p{4cm}@{}}
        \includegraphics[width=2.8cm, align=c]{#1} &
        \includegraphics[width=2.8cm, align=c]{#2} &
        \includegraphics[width=2.8cm, align=c]{#3} &
        \begin{tabular}[c]{@{}c@{}}
            {\small 邮箱} \\
            {\small #4} \\
            {\small 微信小程序} \\
            {\small #5}
        \end{tabular} \\[-0.5em]

        {\small 微信公众号} & {\small 官方网站} & {\small CPHOS论坛} & \\
        {\small CPHOS} & {\small \url{www.cphos.cn}} & & \\
    \end{tabular}
}

\endinput
