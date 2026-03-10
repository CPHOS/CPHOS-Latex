# CPHOS LaTeX 模板

<div align="center">
    <img src="logo.jpg" alt="CPHOS Logo" width="600"/>
    <h2>CPHOS 物理竞赛联考 LaTeX 排版模板集合</h2>
</div>

## 模板类型

| 模板 | 目录 |
|------|------|
| 理论试题 | `theory/` |
| 实验试题 | `experiment/` |


## 快速开始

### Latex 环境配置

我们建议使用 [Tectonic](https://tectonic-typesetting.github.io/en-US/) 作为 LaTeX 编译器，确保 `tectonic` 命令可在终端中使用。

设置 `TEXINPUTS` 环境变量包含 `path/to/CPHOS-Latex/theory;path/to/CPHOS-Latex/experiment` 目录，以便 LaTeX 能找到模板文件。

> [!IMPORTANT]
> Tectonic 不支持`TEXINPUTS`环境变量。因此你需要在编译时设置编译参数 `-Z search-path=$env{TEXINPUTS}` 来指定模板文件的搜索路径。

### 理论试题

```bash
cd theory/examples

tectonic -Z search-path=$env{TEXINPUTS} example-paper.tex     # 示例试卷（包含试题与答案）
tectonic -Z search-path=$env{TEXINPUTS} example-answersheet.tex  # 答题卡

# 或者使用 xelatex 编译器
xelatex example-paper.tex
xelatex example-answersheet.tex
```

通过修改 `documentclass` 选项，你可以选择生成不同类型的文档：
```latex
\documentclass[answer]{cphos}        % 生成解答
\documentclass[exam]{cphos}          % 生成试题
```

详细使用说明请参阅 [theory/README.md](theory/README.md)。

### 实验试题

```bash
cd experiment/examples

tectonic -Z search-path=$env{TEXINPUTS} example-paper.tex     # 示例试卷（包含试题、答案与答题卡）

# 或者使用 xelatex 编译器
xelatex example-paper.tex
```

通过修改 `documentclass` 选项，你可以选择生成不同类型的文档：
```latex
\documentclass[answer]{cphos-e}        % 生成解答
\documentclass[exam]{cphos-e}          % 生成试题
\documentclass[answersheet]{cphos-e}  % 生成答题卡
```

详细使用说明请参阅 [experiment/README.md](experiment/README.md)。

## 项目结构

```
CPHOS-Latex/
├── theory/                # 理论试题模板
│   ├── cphos.cls          # 文档类
│   ├── cphos-scoring.sty  # 评分系统
│   ├── assets/            # 资源文件
│   ├── examples/          # 示例文件
│   └── README.md          # 使用说明
├── experiment/            # 实验试题模板
│   ├── cphos-e.cls        # 文档类
│   ├── assets/            # 资源文件
│   ├── examples/          # 示例文件
│   └── README.md          # 使用说明
├── License                # 许可证
└── README.md              # 本文档
```

## 许可证

本项目采用 [MIT](License) 许可证

## 联系方式

- 官网：[www.cphos.cn](https://www.cphos.cn)
- 邮箱：service@cphos.cn
- 微信公众号：CPHOS
