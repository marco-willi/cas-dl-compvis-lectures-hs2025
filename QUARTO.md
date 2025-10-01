# Quarto Documentation for CAS Deep Learning - Computer Vision Project

## Project Overview

This document serves as a reference guide for working with Quarto in the context of this Computer Vision course project.

**Project Type**: Quarto Website (GitPages)  
**Content**: 2-day course on computer vision with deep learning  
**Main Topics**: Introduction, CNNs, Foundation Models, Image Classification, Practical Guidelines

## Essential Resources

- **Official Docs**: https://quarto.org/docs/guide/
- **Build Command**: `make render`
- **Output Directory**: `_output/`

## Project Structure

```
├── _quarto.yml           # Main configuration file
├── index.qmd             # Homepage
├── lectures/             # Full lecture content (.qmd files)
├── slides/               # Presentation slides (.qmd files)
├── pages/                # Additional pages (exercises, quiz, resources)
├── demos/                # Jupyter notebooks (not rendered by default)
├── assets/               # Images, references, macros
│   ├── images/           # Organized by topic (cnns/, intro/, etc.)
│   ├── _macros.tex       # LaTeX macros
│   └── references.bib    # Bibliography
└── _output/              # Rendered HTML output
```

## Configuration (_quarto.yml)

### Project Settings

```yaml
project:
  type: website
  output-dir: _output
  render:
    - "represen*.qmd"     # Selective rendering patterns
    - "index.qmd"
    - "cnn*"
    - "neural_networks.qmd"
    - "!demos/*"          # Exclude demos from rendering

execute:
  freeze: True            # Cache code execution results
```

### Website Metadata

```yaml
author: "Marco Willi"
affiliation: "Institute for Data Science I4DS, FHNW"
bibliography: assets/references.bib
institute: "Institute for Data Science I4DS, FHNW"
```

### Format Settings

```yaml
format:
  html:
    theme: yeti
    css: styles.css
    toc: true              # Table of contents
    code-fold: false       # Don't fold code blocks
    code-tools: true       # Show code tools
    highlight-style: github
```

### Navigation Structure

```yaml
website:
  sidebar:
    logo: "/assets/logo2.png"
    search: true
    contents:
      - text: "Home"
        href: index.qmd
      - section: Slides
        contents:
          - slides/intro.qmd
          - slides/cnns.qmd
      - section: Lectures
        contents:
          - lectures/intro.qmd
          - lectures/cnns.qmd
```

## Document Front Matter (YAML Header)

### Standard Lecture Format

```yaml
---
title: "4 - Convolutional Neural Networks"
params:
   images_path: "/assets/images/cnns/"
---
```

### Slides Format

```yaml
---
title: "Convolutional Neural Networks"
params:
   images_path: "/assets/images/cnns/"
---
```

**Note**: Slides don't need numbered titles like lectures do.

## Quarto-Specific Syntax

### 1. Callout Boxes

Quarto uses `:::` fenced divs with classes for special formatting.

#### Learning Objectives (Standard Pattern)

```markdown
::: {.callout-tip title="Learning Objectives"}
After this lecture you should be able to:

- Explain why CNN inductive biases improve efficiency
- Compute output shapes for convolutional layers
- Distinguish invariance vs equivariance
:::
```

#### Available Callout Types

```markdown
::: {.callout-note}
General information or notes
:::

::: {.callout-tip}
Helpful tips or best practices
:::

::: {.callout-important}
Critical information
:::

::: {.callout-warning}
Warnings or cautions
:::

::: {.callout-caution}
Similar to warning
:::
```

#### Callout Options

```markdown
::: {.callout-note title="Custom Title"}
Content here
:::

::: {.callout-note collapse="true"}
Collapsible content (collapsed by default)
:::

::: {.callout-note collapse="false"}
Collapsible content (expanded by default)
:::

::: {.callout-note appearance="simple"}
Simplified appearance without icon
:::
```

### 2. Figures and Images

#### Basic Image with Caption

```markdown
:::{#fig-cnn-example-rgb-image width=600}
![ ]({{< meta params.images_path >}}cows2_small.png)

[Image Source](https://unsplash.com/...)
:::
```

#### Image with Alt Text

```markdown
![Alt text description]({{< meta params.images_path >}}image.png){width=400}
```

#### Referencing Figures in Text

```markdown
See @fig-cnn-example-rgb-image for an illustration.
```

#### Multi-Column Layout

```markdown
::: {layout-ncol=2}
![Image 1](path/to/image1.jpg)
![Image 2](path/to/image2.jpg)
:::
```

#### Figure Panels with IDs

```markdown
::: {#fig-rl-intro layout-ncol=2}
![](image1.jpg){fig-alt="Description 1" width=90%}
![](image2.jpg){fig-alt="Description 2" width=90%}

Caption for the entire figure group
:::
```

### 3. Mathematical Content

#### Including LaTeX Macros

```markdown
::: {.content-hidden}
$$
{{< include /assets/_macros.tex >}}
$$
:::
```

#### Inline Math

```markdown
The input dimensionality is $H \times W \times C$.
```

#### Display Math (Equation Blocks)

```markdown
\begin{equation}
o = \left\lfloor \frac{i + 2p - d\cdot(k-1) - 1}{s} + 1 \right\rfloor
\end{equation}
```

```markdown
\begin{align}
f(g(\vect{x})) = f(\vect{x})
\end{align}
```

### 4. Interactive Elements

#### Collapsible Details (HTML Details)

```markdown
<details>
<summary>Click for answer</summary>

Content revealed when clicked

</details>
```

#### Video Embedding (YouTube)

```markdown
{{< video https://www.youtube.com/embed/VIDEO_ID start="50" >}}
```

```markdown
{{< video https://www.youtube.com/embed/VIDEO_ID start="50" width="80%" height="80%" >}}
```

#### Direct Video Files

```markdown
{{< video https://example.com/video.mp4 width=1600 >}}
```

### 5. Tables

#### Basic Markdown Table

```markdown
| Aspect | MLP | CNN |
|--------|-----|-----|
| **Connectivity** | Every neuron connects | Local connectivity |
| **Parameters** | Scales with input size | Constant |
```

#### Table with ID and Caption

```markdown
::: {#tbl-mlp-vs-cnn}

| Column 1 | Column 2 |
|----------|----------|
| Data     | Data     |

: Caption text here
:::
```

#### Table with Column Widths

```markdown
| Task | Property | Why? |
|------|----------|------|
| Classification | Invariance | Reason |

: {tbl-colwidths="[20,20,60]"}
```

#### Referencing Tables

```markdown
See @tbl-mlp-vs-cnn for comparison.
```

### 6. Python Code Execution

#### Basic Python Code Block with Execution

```python
```{python}
#| eval: true
#| echo: true
import torch
print("Hello World")
```
```

#### Python with Table Output

```python
```{python}
#| eval: true
#| echo: false
#| label: tbl-example
#| tbl-cap: "Table caption"
#| tbl-subtitle: "Subtitle text"
#| tbl-colwidths: [30,30]

import pandas as pd
from IPython.display import HTML

df = pd.DataFrame({"Col1": [1, 2], "Col2": [3, 4]})
table_html = df.to_html(
    index=False,
    border=0,
    classes="table table-sm table-striped align-middle caption-top"
)
HTML(table_html)
```
```

#### Code Execution Options

```python
#| eval: true          # Execute the code
#| echo: true          # Show the code
#| echo: false         # Hide the code
#| output: false       # Hide output
#| warning: false      # Hide warnings
#| message: false      # Hide messages
```

### 7. Citations and References

#### Citing References

```markdown
According to @krizhevsky_imagenet_2012, CNNs are effective.

Multiple citations [@he_deep_2016; @simonyan_very_2015].

Source: @johnson_eecs_2019
```

#### Bibliography Section

```markdown
## References

::: {#refs}
:::
```

**Note**: References are automatically populated from `assets/references.bib`.

### 8. Layout and Columns

#### Two-Column Layout

```markdown
:::: {.columns}

::: {.column width="50%"}
Content for left column
:::

::: {.column width="50%"}
Content for right column
:::

::::
```

#### Three-Column Layout with Nested Content

```markdown
:::: {.columns}

::: {.column width="33%"}
Left content
:::

::: {.column width="33%"}
Middle content
:::

::: {.column width="34%"}
Right content
:::

::::
```

### 9. Special Quarto Shortcodes

#### Meta Parameter References

```markdown
{{< meta params.images_path >}}
```

This references parameters defined in the YAML front matter.

#### Include External Files

```markdown
{{< include /path/to/file.tex >}}
```

### 10. Conditional Content

#### Format-Specific Content

```markdown
::: {.content-hidden unless-format="html"}
This only appears in HTML output
:::

::: {.content-hidden when-format="pdf"}
This is hidden in PDF output
:::

::: {.content-visible when-format="pdf"}
This only appears in PDF output
:::
```

### 11. Slides-Specific Features

#### Slide Separators

```markdown
# Section Title

## Slide Title

Content for slide

## Next Slide Title

Content for next slide
```

#### Fragment (Incremental Reveal)

```markdown
::: {.fragment}
This appears incrementally in slides
:::
```

## Common Patterns in This Project

### 1. Standard Lecture Structure

```markdown
---
title: "N - Lecture Title"
params:
   images_path: "/assets/images/topic/"
---

::: {.callout-tip title="Learning Objectives"}
After this lecture you should be able to:
- Objective 1
- Objective 2
:::

::: {.content-hidden}
$$
{{< include /assets/_macros.tex >}}
$$
:::

## Section 1

Content...

## References

::: {#refs}
:::
```

### 2. Interactive Quiz Pattern

```markdown
::: {.callout-note title="📝 Quiz: Topic" collapse="true"}

**Problem**: Description

**Question**: What is the answer?

**Step-by-step solution**:
1. Step one
2. Step two

**Answer**: Final answer

**Intuition**: Explanation
:::
```

### 3. Question with Collapsible Answer

```markdown
::: {.callout-note appearance="simple"}

**Question**

Question text here

**Hint**: Optional hint

<details>
<summary>Click for answer</summary>

Detailed answer content

**Key Insight**: Important takeaway
</details>

:::
```

### 4. Best Practices/Tips Pattern

```markdown
::: {.callout-tip title="Best Practice"}
**Title**: Brief description

- ✅ Do this
- ✅ Also do this
- ❌ Avoid this
:::
```

### 5. Domain-Specific Design Tables

```markdown
::: {.callout-tip title="Domain-Specific Design"}
Different domains need different approaches:

| Domain | Feature | Why? |
|--------|---------|------|
| Natural Images | Small kernels | Fine details |
| Medical | Large kernels | Anatomical features |

: {tbl-colwidths="[30,20,50]"}

Understanding your data is crucial!
:::
```

## Important Differences from Standard Markdown

1. **Triple colons (`:::`)** for divs instead of HTML div tags
2. **Curly braces with classes** like `{.callout-note}` for styling
3. **Shortcodes** use `{{< >}}` syntax
4. **Cross-references** use `@` prefix (e.g., `@fig-name`, `@tbl-name`)
5. **Code execution** is built-in with `{python}` blocks and `#|` directives
6. **Freeze execution** caches results for faster rebuilds
7. **Attributes order matters**: Must be ID, then classes, then key-value pairs (e.g., `{#id .class key="value"}`)
8. **Lists require blank lines**: Unlike GitHub/Jupyter, lists must have a blank line before them
9. **Spans for styling**: Use `[text]{.class}` for inline styling like `.smallcaps`, `.underline`, `.mark`
10. **Raw content**: Use ` ```{=format}` for format-specific raw content (HTML, LaTeX, Typst)

## Build and Rendering

### Render the Website

```bash
make render
```

### Selective Rendering

The `_quarto.yml` file controls what gets rendered:

```yaml
render:
  - "represen*.qmd"     # Wildcard patterns
  - "index.qmd"         # Specific files
  - "!demos/*"          # Exclusions (! prefix)
```

### Freeze Execution

```yaml
execute:
  freeze: True
```

This caches Python execution results in `_freeze/` directory. Useful for:
- Faster rebuilds
- Consistent outputs
- Not re-running expensive computations

## Common Gotchas

1. **Nested divs require different numbers of colons**: Use `::::` for outer and `:::` for inner
2. **Cross-references need IDs**: Use `{#fig-id}` or `{#tbl-id}` syntax
3. **Reserved prefixes**: Don't use `fig-`, `tbl-`, `lst-`, `tip-`, `nte-`, `wrn-`, `imp-`, `cau-`, `thm-`, `lem-`, `cor-`, `prp-`, `cnj-`, `def-`, `exm-`, `exr-`, `sol-`, `rem-`, `alg-`, `eq-`, `sec-` unless creating cross-references
4. **Avoid underscores in IDs**: Use hyphens instead (underscores cause LaTeX/PDF issues)
5. **Cross-reference IDs must be lowercase**: `#fig-MyPlot` won't work, use `#fig-my-plot`
6. **Images need proper paths**: Use `{{< meta params.images_path >}}` for consistency
7. **Citations need `.bib` entry**: Ensure reference exists in `assets/references.bib`
8. **Code blocks need proper fencing**: Use triple backticks with `{python}` for execution
9. **Table captions**: Use `:` on a new line after the table for captions
10. **Callout syntax**: Always use `.callout-type` (with dot) in curly braces
11. **Lists need blank lines**: Always put a blank line before a list or it won't render as a list
12. **Attribute order**: ID first, then classes, then key-value pairs (`{#id .class key="val"}`)

## Testing and Validation

### Preview During Development

```bash
quarto preview
```

### Check for Broken Links

```bash
quarto check
```

### Validate YAML

Ensure proper indentation and syntax in `_quarto.yml` and document YAML headers.

## Best Practices for This Project

1. **Use consistent naming**: Prefix figures/tables with topic (e.g., `fig-cnn-`, `tbl-rl-`)
2. **Leverage parameters**: Define `images_path` in YAML front matter
3. **Include LaTeX macros**: Always include `_macros.tex` for consistent math notation
4. **Add learning objectives**: Start lectures with objectives callout
5. **Use collapsible quizzes**: Make practice content collapsible with `collapse="true"`
6. **Provide step-by-step solutions**: Break down complex calculations
7. **Include intuition**: Add "Key Insight" or "Intuition" sections
8. **Cross-reference**: Link between figures, tables, and sections
9. **Cite sources**: Always credit image sources and papers
10. **Test interactivity**: Ensure collapsible elements and videos work in HTML output

## Additional Resources

- **Quarto Guide**: https://quarto.org/docs/guide/
- **Markdown Basics**: https://quarto.org/docs/authoring/markdown-basics.html
- **Cross-references**: https://quarto.org/docs/authoring/cross-references.html
- **Callouts**: https://quarto.org/docs/authoring/callouts.html
- **Python Code**: https://quarto.org/docs/computations/python.html
- **Figures**: https://quarto.org/docs/authoring/figures.html
- **Tables**: https://quarto.org/docs/authoring/tables.html

## Execution Management

### Freeze vs Cache

**Freeze** (`execute: freeze`):
- Stores computational results in `_freeze/` directory
- Used for project-wide rendering optimization
- Two modes:
  - `freeze: true` - Never re-render during project render
  - `freeze: auto` - Re-render only when source changes
- Check `_freeze/` into version control
- Delete `_freeze/` folder to force complete re-execution
- Still executes when rendering individual files: `quarto render file.qmd`

**Cache** (`execute: cache`):
- Uses Knitr cache (R) or Jupyter Cache (Python)
- Invalidates based on chunk source code changes
- Refresh with: `quarto render --cache-refresh`
- Project-wide refresh: `quarto render --cache-refresh` (no file specified)

**Working Directory**:
```yaml
project:
  execute-dir: project  # Use project root instead of file directory
```

**Environment Variable**: `QUARTO_PROJECT_DIR` contains the project directory path

### Incremental Rendering

```bash
quarto render introduction.qmd    # Single file
quarto render subdir/              # Directory
```

Even with incremental render, project structure is maintained (e.g., full book is produced using cached chapters).

## Advanced Syntax Features

### Spans for Inline Formatting

```markdown
[Small caps text]{.smallcaps}
[Underlined text]{.underline}
[Highlighted text]{.mark}
```

### Raw Content for Specific Formats

```markdown
```{=html}
<iframe src="https://example.com"></iframe>
```

```{=latex}
\renewcommand*{\labelitemi}{\textgreater}
```

```{=typst}
#set text(fill: red)
```

Inline raw: `Here's some raw inline HTML: <a>html</a>`{=html}
```

### Footnotes

```markdown
Here is a footnote reference,[^1] and another.[^longnote]

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented.
```

Inline footnote: `Here is an inline note.^[Inlines notes are easier to write.]`

### Line Blocks (Preserve Spacing)

```markdown
| Line Block
|   Spaces and newlines
|   are preserved
```

### Keyboard Shortcuts

```markdown
{{< kbd Shift-Ctrl-P >}}
{{< kbd mac=Shift-Command-O win=Shift-Control-O linux=Shift-Ctrl-L >}}
```

### Diagrams (Mermaid & Graphviz)

```markdown
```{mermaid}
flowchart LR
  A[Hard edge] --> B(Round edge)
  B --> C{Decision}
  C --> D[Result one]
  C --> E[Result two]
```
```

### Page Breaks

```markdown
page 1

{{< pagebreak >}}

page 2
```

## Cross-Reference Variations

### Reference Syntax Options

| Syntax | Example | Output |
|--------|---------|--------|
| Default | `@fig-elephant` | "Figure 1" |
| Capitalized | `@Fig-elephant` | "Figure 1" |
| Custom prefix | `[Fig @fig-elephant]` | "Fig 1" |
| No prefix | `[-@fig-elephant]` | "1" |
| Multiple | `[@fig-a; @fig-b; @fig-c]` | "Figures 1, 2, and 3" |

### Subfigures Auto-naming

When using `fig-subcap`, subfigure labels are automatically created:
- Main label: `#fig-plots`
- Subfigure 1: `@fig-plots-1`
- Subfigure 2: `@fig-plots-2`

Same for subtables: `@tbl-panel-1`, `@tbl-panel-2`

### Cross-Reference Prefixes

| Type | Prefix | Example |
|------|--------|---------|
| Figure | `#fig-` | `#fig-diagram` |
| Table | `#tbl-` | `#tbl-results` |
| Equation | `#eq-` | `#eq-quadratic` |
| Section | `#sec-` | `#sec-intro` |
| Code Listing | `#lst-` | `#lst-algorithm` |
| Theorem | `#thm-` | `#thm-pythagorean` |
| Lemma | `#lem-` | `#lem-helper` |
| Definition | `#def-` | `#def-derivative` |
| Note callout | `#nte-` | `#nte-important` |
| Tip callout | `#tip-` | `#tip-performance` |
| Warning callout | `#wrn-` | `#wrn-danger` |
| Important callout | `#imp-` | `#imp-security` |
| Caution callout | `#cau-` | `#cau-breaking` |

### Section Cross-References

```markdown
## Introduction {#sec-introduction}

See @sec-introduction for context.
```

**Important**: Enable `number-sections: true` in YAML for section references to work.

### Equations with Labels

```markdown
Black-Scholes (@eq-black-scholes) is a model:

$$
\frac{\partial C}{\partial t} + \frac{1}{2}\sigma^{2} S^{2}
$$ {#eq-black-scholes}
```

## Code Execution Advanced Options

### Cell Options (Comprehensive)

```python
```{python}
#| eval: true          # Execute code
#| echo: true          # Show code
#| output: true        # Show output
#| warning: true       # Show warnings
#| error: false        # Don't show errors (stop on error)
#| include: true       # Include everything
#| cache: false        # Don't cache results
#| freeze: false       # Don't freeze results
#| fig-width: 7        # Figure width in inches
#| fig-height: 5       # Figure height in inches
#| fig-cap: "Caption"  # Figure caption
#| fig-alt: "Alt text" # Accessibility alt text
#| label: fig-plot     # Cross-reference label
#| code-fold: false    # Don't fold code
#| code-overflow: wrap # Wrap long code lines
```
```

### Output Options

```python
#| output: false      # Hide all output
#| output: true       # Show output (default)
#| output: asis       # Raw markdown output (no Quarto div wrapping)
```

### Echo Options

```python
#| echo: false        # Hide code
#| echo: true         # Show code
#| echo: fenced       # Show code with fenced delimiter and YAML options
```

### Figure Options for Subplots

```python
#| label: fig-plots
#| fig-cap: "Main caption"
#| fig-subcap:
#|   - "Subplot 1"
#|   - "Subplot 2"
#| layout-ncol: 2
```

Or for identifier-only subcaptions:
```python
#| fig-subcap: true
```

### Combining Code Listing and Figure Cross-refs

```python
```{python}
#| label: fig-output          # For the figure
#| fig-cap: "Figure caption"
#| lst-label: lst-code        # For the code itself
#| lst-cap: "Code caption"

plt.plot([1,2,3,4])
plt.show()
```

Reference as: @lst-code produces @fig-output.
```

### Jupyter-Specific Options

```yaml
---
ipynb-shell-interactivity: all  # Print all expressions (default: last_expr)
---
```

### Unexecuted Documentation Blocks

Use double braces to show code without executing:

````markdown
```{{python}}
# This code is shown but not executed
1 + 1
```
````

For complex examples with multiple blocks, use 4+ backticks:

`````markdown
````
---
title: "Example"
---

```{{python}}
print("Not executed")
```
````
`````

## Quick Reference: Common Commands

| Task | Syntax |
|------|--------|
| Callout box | `::: {.callout-type}` ... `:::` |
| Figure with ID | `:::{#fig-id}` ... `:::` |
| Reference figure | `@fig-id` |
| Custom reference | `[Fig @fig-id]` (custom prefix) |
| No-prefix reference | `[-@fig-id]` (number only) |
| Multiple references | `[@fig-a; @fig-b; @fig-c]` |
| Include file | `{{< include path >}}` |
| Meta parameter | `{{< meta params.name >}}` |
| Math equation | `\begin{equation}` ... `\end{equation}` |
| Equation with label | `$$ ... $$ {#eq-label}` |
| Python code | ` ```{python}` ... ` ``` ` |
| Unexecuted code | ` ```{{python}}` ... ` ``` ` |
| Citation | `@citation_key` |
| Multiple citations | `[@cite1; @cite2]` |
| Collapsible | `<details><summary>` ... `</summary></details>` |
| Video embed | `{{< video url >}}` |
| Page break | `{{< pagebreak >}}` |
| Keyboard shortcut | `{{< kbd Ctrl-C >}}` |
| Two columns | `:::: {.columns}` with `:::  {.column width="50%"}` |
| Span with class | `[text]{.smallcaps}` |
| Raw HTML | ` ```{=html}` ... ` ``` ` |
| Inline footnote | `text^[footnote content]` |
| Diagram (Mermaid) | ` ```{mermaid}` ... ` ``` ` |

---

**Last Updated**: October 1, 2025  
**Maintainer**: AI Assistant for CAS Deep Learning Project
