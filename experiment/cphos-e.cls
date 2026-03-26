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
\captionsetup[table]{position=above, font=bf, labelfont=bf}  % 表格标题在上方，全粗体
\RequirePackage{array}
\RequirePackage{ltablex}  % 结合 longtable + tabularx：跨页 + 自动列宽
\RequirePackage{wrapfig}           % 文字环绕图片支持
\RequirePackage{subcaption}        % 子图支持
\RequirePackage{etoolbox}          % 用于 AtBeginEnvironment
\RequirePackage[colorlinks=true, linkcolor=black, citecolor=black, urlcolor=cyan]{hyperref}
\RequirePackage{upgreek}
\RequirePackage{bm}
\RequirePackage{comment}

% === 字体设置 ===
\setmainfont{Times New Roman}
\setCJKmainfont[BoldFont=SimHei]{SimSun}
\setCJKfamilyfont{kai}[AutoFakeBold=2]{KaiTi}
\newcommand{\kaiti}{\CJKfamily{kai}}

% === 页面设置 ===
\ifcphos@answer
    % answer模式：三栏布局需要更宽的版面（1.53+1.4+16.05=18.98cm）
    \geometry{
        left=1cm,
        right=1cm,
        top=2.34cm,
        bottom=2.54cm,
        headheight=1.5cm,
        headsep=0.5cm,
        footskip=1cm
    }
\else\ifcphos@answersheet
    % answersheet模式：与answer模式一致的页边距
    \geometry{
        left=1cm,
        right=1cm,
        top=2.34cm,
        bottom=2.54cm,
        headheight=1.5cm,
        headsep=0.5cm,
        footskip=1cm
    }
\else
    \geometry{
        left=3.17cm,
        right=3.17cm,
        top=2.34cm,
        bottom=2.54cm,
        headheight=1.5cm,
        headsep=0.5cm,
        footskip=1cm
    }
\fi\fi
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
\ifcphos@answersheet
    \fancyhead[C]{\kaiti\small 姓名：}
    \renewcommand{\headrulewidth}{0pt}
\else\ifcphos@answer
    \renewcommand{\headrulewidth}{0pt}  % answer模式无页眉分割线
\else
    \renewcommand{\headrulewidth}{0.4pt}
\fi\fi
\fancyfoot[L]{\thepage\ / \pageref{LastPage}}
\fancyfoot[R]{\copyright\ \the\year\ CPHOS}
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

% === 计数器 ===
\newcounter{problemnum}
\newcounter{totalscore}

% 固定三层编号: B. / 1. / B.1.1
\newcounter{expPart}[problemnum]
\newcounter{expQ}[expPart]

% === 图片/表格编号系统 ===
% 题干图片计数器和解答图片计数器
\newcounter{problemfignum}[problemnum]
\newcounter{solutionfignum}[problemnum]
\newif\ifcphos@insolution
\newif\ifcphos@firstexpanswer
\cphos@firstexpanswertrue
\cphos@insolutionfalse

% 在 figure/wrapfigure 环境开始时递增正确的计数器
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

% 重定义 figure 编号格式
\renewcommand{\thefigure}{%
    \ifcphos@insolution
        \Alph{problemnum}.\arabic{solutionfignum}%
    \else
        \Alph{problemnum}.\arabic{problemfignum}%
    \fi
}

% 重定义 table 编号格式（直接使用标准 table 计数器，加题号前缀）
\renewcommand{\thetable}{\Alph{problemnum}.\arabic{table}}

% 图片 caption 标签格式
\DeclareCaptionLabelFormat{problemfig}{图~#2}
\DeclareCaptionLabelFormat{solutionfig}{答图~#2}
\captionsetup[figure]{labelformat=problemfig}

% 子图编号格式：中文全角括号（a）（b）等
\renewcommand{\thesubfigure}{（\alph{subfigure}）}
\captionsetup[subfigure]{labelformat=simple, labelsep=space, font=small}

% === 题号转中文 ===
\newcommand{\chnnum}[1]{%
    \ifcase#1\or 一\or 二\or 三\or 四\or 五\or 六\or 七\or 八\or 九\or 十\fi
}

% === 自定义带透明度与高度控制的灰底高亮 ===
\newcommand{\cphoshl}[1]{%
    \tikz[baseline=(X.base)] \node [
        fill=black!40,        % 填充颜色（配合透明度稍微加深一点基色）
        fill opacity=0.25,    % 背景透明度（0.25表示透出75%的水印，完美解决遮挡）
        text opacity=1,       % 文字完全不透明
        inner xsep=0.3em,     % 左右边距
        inner ysep=0.15em,    % 上下边距（调小此值，使灰底只占行高80%左右）
        outer sep=0pt,
        rounded corners=1pt   % 加一点点圆角，视觉上更精致
    ] (X) {#1};%
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
    \ifcphos@answer
        % answer模式：设置分值检查的题目总分
        \ifx\cphos@problem@score\@empty\else
            \cphosExpSetProblemScore{#1}%
        \fi
        % answer模式：显示数值评分标准（仅首题），然后显示题目标题
        \ifnum\value{problemnum}=1
            \scoringrule
        \fi
        \vspace{0.5em}%
    \else\ifcphos@answersheet
        % answersheet模式：设置分值检查但不显示评分标准
        \ifx\cphos@problem@score\@empty\else
            \cphosExpSetProblemScore{#1}%
        \fi
        \vspace{0.5em}%
    \else
        % exam模式：正常显示题目
        \vspace{1em}%
        \begin{center}
            \fontsize{12pt}{15pt}\selectfont
            {\bfseries \Alph{problemnum}.#2%
                \ifx\cphos@problem@score\@empty\else（#1分）\fi}%
        \end{center}%
    \fi\fi
}{%
    \par%
}

% === 实验正文环境（替代理论版problemstatement） ===
% answer/answersheet模式下隐藏题干，exam模式下显示
\ifcphos@exam
    \newenvironment{expcontent}{%
        \setcounter{problemfignum}{0}%
        \setcounter{table}{0}%
        \setlength{\parindent}{2em}%
    }{%
        \par\vspace{\baselineskip}%
    }
\else
    \excludecomment{expcontent}
\fi

% === 实验答案/答题卡环境三栏布局（answer/answersheet模式显示，exam模式隐藏） ===
% 三栏宽度（含边框）: 第一栏1.53cm, 第二栏1.4cm, 第三栏16.05cm，总宽18.98cm
\newlength{\cphos@colA}
\newlength{\cphos@colB}
\newlength{\cphos@colC}
\setlength{\cphos@colA}{1.53cm}
\setlength{\cphos@colB}{1.4cm}
\setlength{\cphos@colC}{16.05cm}

% 解答计数器
\newcounter{ansPartNum}[problemnum]    % 大题内的部分编号（对应pmark）
\newcounter{ansSubQNum}[ansPartNum]    % 小题编号（对应subq）

% 存储当前大题和部分的信息
\def\cphos@currentProblem{\Alph{problemnum}}
\def\cphos@currentPart{0}
\def\cphos@currentPartScore{}
\newif\ifcphos@firstSubQ

\ifcphos@answer
    % === answer 模式 ===
    \RequirePackage{longtable}
    \RequirePackage{multirow}
    \RequirePackage{hhline}

   % 数值评分标准说明
    \newcommand{\scoringrule}{%
        {% 作用域开始
        \bfseries\boldmath
        \noindent *数值评分遵循以下标准：%
        \par\vspace{0.5em}%
        
        % 使用 \centering 让公式居中，\par 保证居中段落正确结束
        {\centering $Y = y_0$，\quad Num $= A - B - X$；$\Delta = 0 - \alpha - \beta$\par}%
        
        \vspace{0.3em}%
        \noindent 若考生给出$y$的有效位数为$A$，数值为$|y - y_0| \le \alpha$，不扣分；有效位数为$B$，或%
        $|y - y_0| \in (\alpha, \beta]$，或物理量少单位，扣除50\%分数；有效位数为$A, B$以外的值，或$|y - y_0| > \beta$，%
        扣除100\%分数。该扣分得分扣完为止。计算过程中有效数字可以多（少）保留一位。没有给出Num的，表示与答案不同的有效位数扣除100\%分数；%
        没有给出$\Delta$的，允许在末位出现1的偏差，否则扣除100\%分数。%
        \par\vspace{1em}%
        }% 作用域结束
    }

    % \spt{分值} 或 \spt[内容]{分值} - 得分点标记
    \NewDocumentCommand{\spt}{o m}{%
        \IfValueT{#1}{\cphoshl{\textbf{#1}}}%
        \cphosExpRecordSpt{#2}%
    }

    % \anspart[分数] - 开始新的大题部分
    \NewDocumentCommand{\anspart}{o}{%
        \refstepcounter{ansPartNum}%
        \setcounter{ansSubQNum}{0}%
        \xdef\cphos@currentPart{\arabic{ansPartNum}}%
        \IfValueTF{#1}{%
            \gdef\cphos@currentPartScore{#1}%
            \cphosExpBeginAnspart{\Alph{problemnum}.\cphos@currentPart}{#1}%
        }{%
            \gdef\cphos@currentPartScore{}%
            \cphosExpBeginAnspart{\Alph{problemnum}.\cphos@currentPart}{}%
        }%
        \global\cphos@firstSubQtrue
    }

    % \ansq[分数]{解答内容}{答题卡内容} - answer模式显示第2参数
    \NewDocumentCommand{\ansq}{o +m +g}{%
        \refstepcounter{ansSubQNum}%
        \IfValueTF{#1}{%
            \cphosExpBeginAnsq{\Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}}{#1}%
        }{%
            \cphosExpBeginAnsq{\Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}}{}%
        }%
        \ifcphos@firstSubQ
            \Alph{problemnum}.\cphos@currentPart%
            \ifx\cphos@currentPartScore\@empty\else\newline\vspace{0.2em}\cphoshl{\textbf{\cphos@currentPartScore pt}}\fi%
            \global\cphos@firstSubQfalse
        \fi
        &
        \Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}%
        \IfValueT{#1}{\newline\vspace{0.2em}\cphoshl{\textbf{#1pt}}}%
        &
        #2 \\
        \hhline{|~|-|-|}%
    }

    % \anslastq[分数]{解答内容}{答题卡内容} - answer模式显示第2参数
    \NewDocumentCommand{\anslastq}{o +m +g}{%
        \refstepcounter{ansSubQNum}%
        \IfValueTF{#1}{%
            \cphosExpBeginAnsq{\Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}}{#1}%
        }{%
            \cphosExpBeginAnsq{\Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}}{}%
        }%
        &
        \Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}%
        \IfValueT{#1}{\newline\vspace{0.2em}\cphoshl{\textbf{#1pt}}}%
        &
        #2 \\
        \hline%
    }

    % expanswer环境
    \newenvironment{expanswer}{%
        \cphos@insolutiontrue
        \captionsetup[figure]{labelformat=solutionfig}%
        \setcounter{solutionfignum}{0}%
        \setcounter{ansPartNum}{0}%
        \setcounter{ansSubQNum}{0}%
        \xdef\cphos@currentProblem{\Alph{problemnum}}%
        \cphosExpClearState%
        \kaiti%
        \setlength{\LTleft}{0pt}%
        \setlength{\LTright}{0pt}%
        \setlength{\LTpre}{0pt}%
        \setlength{\LTpost}{0pt}%
        \setlength{\tabcolsep}{0pt}%
        \renewcommand{\arraystretch}{1.5}%
        \begin{longtable}{@{}|>{\centering\arraybackslash}m{\cphos@colA}|>{\centering\arraybackslash}m{\cphos@colB}|m{\cphos@colC}|@{}}
        \hline
        \endfirsthead
        \hline
        \endhead
        \hline
        \endfoot
        \endlastfoot
    }{%
        \end{longtable}\endgraf\nointerlineskip\kern-\arrayrulewidth%
        \cphosExpCheckAndOutput%
        \cphos@insolutionfalse
        \captionsetup[figure]{labelformat=problemfig}%
    }

\else\ifcphos@answersheet
    % === answersheet 模式 ===
    \RequirePackage{longtable}
    \RequirePackage{multirow}
    \RequirePackage{hhline}

    % answersheet模式不显示评分标准
    \newcommand{\scoringrule}{}

    % \ansblank{n} - 生成n行空白区域供答题
    \newcommand{\ansblank}[1]{%
        \vspace{#1\baselineskip}%
    }

    % \spt 在 answersheet 模式下不输出任何内容
    \NewDocumentCommand{\spt}{o m}{}

    % \anspart[分数] - answersheet模式显示分数（与answer一致）
    \NewDocumentCommand{\anspart}{o}{%
        \refstepcounter{ansPartNum}%
        \setcounter{ansSubQNum}{0}%
        \xdef\cphos@currentPart{\arabic{ansPartNum}}%
        \IfValueTF{#1}{%
            \gdef\cphos@currentPartScore{#1}%
        }{%
            \gdef\cphos@currentPartScore{}%
        }%
        \global\cphos@firstSubQtrue
    }

    % \ansq[分数]{解答内容}{答题卡内容} - answersheet模式显示第3参数，但分数布局与answer一致
    \NewDocumentCommand{\ansq}{o +m +g}{%
        \refstepcounter{ansSubQNum}%
        \ifcphos@firstSubQ
            \Alph{problemnum}.\cphos@currentPart%
            \ifx\cphos@currentPartScore\@empty\else\newline\vspace{0.2em}\cphoshl{\textbf{\cphos@currentPartScore pt}}\fi%
            \global\cphos@firstSubQfalse
        \fi
        &
        \Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}%
        \IfValueT{#1}{\newline\vspace{0.2em}\cphoshl{\textbf{#1pt}}}%
        &
        \IfValueTF{#3}{#3}{} \\
        \hhline{|~|-|-|}%
    }

    % \anslastq[分数]{解答内容}{答题卡内容} - answersheet模式显示第3参数，但分数布局与answer一致
    \NewDocumentCommand{\anslastq}{o +m +g}{%
        \refstepcounter{ansSubQNum}%
        &
        \Alph{problemnum}.\cphos@currentPart.\arabic{ansSubQNum}%
        \IfValueT{#1}{\newline\vspace{0.2em}\cphoshl{\textbf{#1pt}}}%
        &
        \IfValueTF{#3}{#3}{} \\
        \hline%
    }

    % expanswer环境 - answersheet版本
    \newenvironment{expanswer}{%
        \cphos@insolutiontrue
        \captionsetup[figure]{labelformat=solutionfig}%
        \setcounter{solutionfignum}{0}%
        \setcounter{ansPartNum}{0}%
        \setcounter{ansSubQNum}{0}%
        \xdef\cphos@currentProblem{\Alph{problemnum}}%
        \kaiti%
        \setlength{\LTleft}{0pt}%
        \setlength{\LTright}{0pt}%
        \setlength{\LTpre}{0pt}%
        \setlength{\LTpost}{0pt}%
        \setlength{\tabcolsep}{0pt}%
        \renewcommand{\arraystretch}{1.5}%
        \begin{longtable}{@{}|>{\centering\arraybackslash}m{\cphos@colA}|>{\centering\arraybackslash}m{\cphos@colB}|m{\cphos@colC}|@{}}
        \hline
        \endfirsthead
        \hline
        \endhead
        \hline
        \endfoot
        \endlastfoot
    }{%
        \end{longtable}\endgraf\nointerlineskip\kern-\arrayrulewidth%
        \cphos@insolutionfalse
        \captionsetup[figure]{labelformat=problemfig}%
    }

\else
    % === exam 模式 ===
    \excludecomment{expanswer}
    \newcommand{\anspart}[1][]{}
    \NewDocumentCommand{\ansq}{o +m +g}{}
    \NewDocumentCommand{\anslastq}{o +m +g}{}
\fi\fi

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

% === 表格支持说明 ===
% 短表格（固定位置）：\begin{table}[H] \begin{tabular}...\end{tabular} \end{table}
% 跨页+自动列宽：\begin{tabularx}{\textwidth}{|c|X|X|...} ... \end{tabularx}
%   - X 列类型自动分配剩余宽度，总宽度 = \textwidth
%   - 由 ltablex 宏包提供，支持跨页
% 已加载宏包：float（H位置符）、ltablex（跨页+自动列宽）、array（列格式）

% === 标题页命令 ===
\newcommand{\maketitlepage}{%
    \ifcphos@exam
        % exam模式：显示标题页
        \thispagestyle{firstpage}%
        \begin{center}
            {\fontsize{16pt}{24pt}\selectfont\bfseries \cphos@title} \\[0.3em]
            {\fontsize{14pt}{21pt}\selectfont\bfseries \cphos@subtitle}
        \end{center}
    \fi
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
    % 仅exam模式显示的通用环境
    \newenvironment{examonly}{}{}
\else
    \excludecomment{examschedule}
    \excludecomment{examonly}
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

% === 版权信息环境（仅exam模式显示，不分页） ===
\ifcphos@exam
    \newenvironment{copyrightinfo}{%
        \par\vspace{2em}%
        \noindent\begin{minipage}{\textwidth}%
    }{%
        \end{minipage}%
        \par%
    }
\else
    \excludecomment{copyrightinfo}
\fi

% === 联系方式（仅exam模式显示） ===
\ifcphos@exam
    \newcommand{\contactinfo}{%
        \begin{center}
            {\bfseries 联系方式}
        \end{center}
        \vspace{0.5em}
        \noindent
        \begin{tabular}{@{}c@{\quad}c@{\quad}c@{\quad}p{4cm}@{}}
            \includegraphics[width=2.9cm, align=c]{assets/fig1.jpg} &
            \includegraphics[width=2.9cm, align=c]{assets/fig2.png} &
            \includegraphics[width=2.9cm, align=c]{assets/fig3.png} &
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
\else
    \newcommand{\contactinfo}{}
\fi

% =========================================================================
% === 分值检查机制（answer模式专用）===
% =========================================================================
\ExplSyntaxOn

% --- 全局开关 ---
\bool_new:N \g__cphos_exp_check_score_bool
\bool_gset_false:N \g__cphos_exp_check_score_bool

% \setscorecheck{true/false} - 开启或关闭分值检查
\NewDocumentCommand{\setscorecheck}{m}{
    \str_if_eq:nnTF {#1} {true} {
        \bool_gset_true:N \g__cphos_exp_check_score_bool
    }{
        \bool_gset_false:N \g__cphos_exp_check_score_bool
    }
}

% --- 题目总分 ---
\tl_new:N \g__cphos_exp_problem_score_tl
\cs_new:Npn \cphosExpSetProblemScore #1 {
    \tl_gset:Nn \g__cphos_exp_problem_score_tl {#1}
}

% --- 警告序列 ---
\seq_new:N \g__cphos_exp_warnings_seq

% --- 分值追踪（使用浮点数）---
\fp_new:N \g__cphos_exp_spt_actual_fp       % 当前 ansq 的 spt 累计
\fp_new:N \g__cphos_exp_ansq_actual_fp      % 当前 anspart 的 ansq 累计
\fp_new:N \g__cphos_exp_anspart_actual_fp   % 整个 problem 的 anspart 累计

% --- 当前层级信息 ---
\tl_new:N \g__cphos_exp_current_part_label_tl   % 当前 anspart 标签（如 A.1）
\tl_new:N \g__cphos_exp_anspart_declared_tl     % 当前 anspart 声明分值
\tl_new:N \g__cphos_exp_current_q_label_tl      % 当前 ansq 标签（如 A.1.3）
\tl_new:N \g__cphos_exp_ansq_declared_tl        % 当前 ansq 声明分值
\bool_new:N \g__cphos_exp_has_spt_bool          % 当前 ansq 是否有 spt

% --- 清除状态 ---
\cs_new:Npn \__cphos_exp_clear_state: {
    \fp_gzero:N \g__cphos_exp_spt_actual_fp
    \fp_gzero:N \g__cphos_exp_ansq_actual_fp
    \fp_gzero:N \g__cphos_exp_anspart_actual_fp
    \tl_gclear:N \g__cphos_exp_anspart_declared_tl
    \tl_gclear:N \g__cphos_exp_ansq_declared_tl
    \tl_gclear:N \g__cphos_exp_current_part_label_tl
    \tl_gclear:N \g__cphos_exp_current_q_label_tl
    \seq_gclear:N \g__cphos_exp_warnings_seq
    \bool_gset_false:N \g__cphos_exp_has_spt_bool
}

% --- 检查当前 ansq 的 spt 总和（立即检查，不延迟）---
\cs_new:Npn \__cphos_exp_check_current_ansq: {
    \bool_if:NT \g__cphos_exp_check_score_bool {
        \tl_if_empty:NF \g__cphos_exp_ansq_declared_tl {
            \bool_if:NT \g__cphos_exp_has_spt_bool {
                \fp_compare:nNnF { \g__cphos_exp_spt_actual_fp } = { \g__cphos_exp_ansq_declared_tl } {
                    \seq_gput_right:Nx \g__cphos_exp_warnings_seq {
                        小题~\g__cphos_exp_current_q_label_tl ：声明~\g__cphos_exp_ansq_declared_tl~分，spt合计~\fp_use:N \g__cphos_exp_spt_actual_fp~分
                    }
                }
            }
        }
    }
    % 将当前 ansq 的声明分值累加到 anspart
    \tl_if_empty:NF \g__cphos_exp_ansq_declared_tl {
        \fp_gadd:Nn \g__cphos_exp_ansq_actual_fp { \g__cphos_exp_ansq_declared_tl }
    }
}

% --- 检查当前 anspart 的 ansq 总和 ---
\cs_new:Npn \__cphos_exp_check_current_anspart: {
    \bool_if:NT \g__cphos_exp_check_score_bool {
        \tl_if_empty:NF \g__cphos_exp_anspart_declared_tl {
            \fp_compare:nNnF { \g__cphos_exp_ansq_actual_fp } = { \g__cphos_exp_anspart_declared_tl } {
                \seq_gput_right:Nx \g__cphos_exp_warnings_seq {
                    大题~\g__cphos_exp_current_part_label_tl ：声明~\g__cphos_exp_anspart_declared_tl~分，ansq合计~\fp_use:N \g__cphos_exp_ansq_actual_fp~分
                }
            }
        }
    }
    % 将当前 anspart 的声明分值累加到 problem
    \tl_if_empty:NF \g__cphos_exp_anspart_declared_tl {
        \fp_gadd:Nn \g__cphos_exp_anspart_actual_fp { \g__cphos_exp_anspart_declared_tl }
    }
}

% --- 在 expanswer 结束时检查所有剩余项 ---
\cs_new:Npn \__cphos_exp_check_all: {
    % 检查最后一个 ansq
    \tl_if_empty:NF \g__cphos_exp_current_q_label_tl {
        \__cphos_exp_check_current_ansq:
    }
    % 检查最后一个 anspart
    \tl_if_empty:NF \g__cphos_exp_current_part_label_tl {
        \__cphos_exp_check_current_anspart:
    }
    % 检查 problem 总分
    \bool_if:NT \g__cphos_exp_check_score_bool {
        \tl_if_empty:NF \g__cphos_exp_problem_score_tl {
            \fp_compare:nNnF { \g__cphos_exp_anspart_actual_fp } = { \g__cphos_exp_problem_score_tl } {
                \seq_gput_right:Nx \g__cphos_exp_warnings_seq {
                    题目总分：声明~\g__cphos_exp_problem_score_tl~分，anspart合计~\fp_use:N \g__cphos_exp_anspart_actual_fp~分
                }
            }
        }
    }
}

% --- 输出警告 ---
\cs_new:Npn \__cphos_exp_output_warnings: {
    \seq_if_empty:NF \g__cphos_exp_warnings_seq {
        \par\noindent\textcolor{red}{\bfseries 【分值检查警告】}
        \seq_map_inline:Nn \g__cphos_exp_warnings_seq {
            \par\noindent\textcolor{red}{##1}
        }
        \par
    }
}

% --- 记录 spt 分值 ---
\cs_new:Npn \__cphos_exp_record_spt:n #1 {
    \fp_gadd:Nn \g__cphos_exp_spt_actual_fp {#1}
    \bool_gset_true:N \g__cphos_exp_has_spt_bool
}

% --- 开始新的 ansq（关键：标签用 x 展开存储）---
\cs_new:Npn \__cphos_exp_begin_ansq:nn #1 #2 {
    % 1. 先检查上一个 ansq（如果存在）
    \tl_if_empty:NF \g__cphos_exp_current_q_label_tl {
        \__cphos_exp_check_current_ansq:
    }
    % 2. 设置新的 ansq 信息（用 x 展开确保标签是当前值）
    \tl_gset:Nx \g__cphos_exp_current_q_label_tl {#1}
    \tl_gset:Nn \g__cphos_exp_ansq_declared_tl {#2}
    \fp_gzero:N \g__cphos_exp_spt_actual_fp
    \bool_gset_false:N \g__cphos_exp_has_spt_bool
}

% --- 开始新的 anspart ---
\cs_new:Npn \__cphos_exp_begin_anspart:nn #1 #2 {
    % 1. 先检查上一个 ansq（如果存在）
    \tl_if_empty:NF \g__cphos_exp_current_q_label_tl {
        \__cphos_exp_check_current_ansq:
    }
    % 2. 再检查上一个 anspart（如果存在）
    \tl_if_empty:NF \g__cphos_exp_current_part_label_tl {
        \__cphos_exp_check_current_anspart:
    }
    % 3. 设置新的 anspart 信息（用 x 展开确保标签是当前值）
    \tl_gset:Nx \g__cphos_exp_current_part_label_tl {#1}
    \tl_gset:Nn \g__cphos_exp_anspart_declared_tl {#2}
    \fp_gzero:N \g__cphos_exp_ansq_actual_fp
    \tl_gclear:N \g__cphos_exp_current_q_label_tl
    \fp_gzero:N \g__cphos_exp_spt_actual_fp
    \bool_gset_false:N \g__cphos_exp_has_spt_bool
}

% --- 公开接口 ---
\cs_new:Npn \cphosExpClearState { \__cphos_exp_clear_state: }
\cs_new:Npn \cphosExpRecordSpt #1 { \__cphos_exp_record_spt:n {#1} }
\cs_new:Npn \cphosExpBeginAnsq #1 #2 { \__cphos_exp_begin_ansq:nn {#1}{#2} }
\cs_new:Npn \cphosExpBeginAnspart #1 #2 { \__cphos_exp_begin_anspart:nn {#1}{#2} }
\cs_new:Npn \cphosExpCheckAndOutput { 
    \__cphos_exp_check_all:
    \__cphos_exp_output_warnings:
}

\ExplSyntaxOff

\endinput
