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

## Configuration (\_quarto.yml)

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

## Creating Reveal.js Slides

Quarto supports creating interactive presentations using [Reveal.js](https://revealjs.com/). This section covers the key features and syntax for creating slide presentations.

### Basic Slide Format

To create a Reveal.js presentation, use the `revealjs` format in your YAML header:

```yaml
---
title: "My Presentation"
author: "Author Name"
format: revealjs
---
```

### Slide Delineation

#### Using Headings

Slides are created using headings. Level 2 headings (`##`) create individual slides:

```markdown
---
title: "Habits"
author: "John Doe"
format: revealjs
---

## Getting up

- Turn off alarm
- Get out of bed

## Going to sleep

- Get in bed
- Count sheep
```

#### Section Slides

Level 1 headings (`#`) create section dividers with title slides:

```markdown
# In the morning

## Getting up

- Turn off alarm
- Get out of bed

## Breakfast

- Eat eggs
- Drink coffee

# In the evening

## Dinner

- Eat spaghetti
- Drink wine
```

#### Horizontal Rules

Use horizontal rules (`---`) for slides without titles:

```markdown
## Slide with Title

Content here

---

Content for slide without title
```

### Title Slide

The title slide is automatically generated from YAML metadata. To omit the title slide, exclude `title` and `author`:

```yaml
---
format: revealjs
---

## First Content Slide

Content starts immediately
```

### Incremental Lists

#### Global Setting

Make all lists incremental (reveal items one at a time):

```yaml
format:
  revealjs:
    incremental: true
```

#### Per-List Control

Make a specific list incremental:

```markdown
::: {.incremental}
- First item
- Second item
- Third item
:::
```

Make a list non-incremental when global setting is true:

```markdown
::: {.nonincremental}
- All items
- Show at once
:::
```

#### Pauses

Insert a pause within a slide using three dots separated by spaces:

```markdown
## Slide with Pause

Content before the pause

. . .

Content revealed after advancing
```

### Multiple Columns

Create side-by-side columns using nested divs:

```markdown
:::: {.columns}

::: {.column width="40%"}
Left column content
:::

::: {.column width="60%"}
Right column content
:::

::::
```

### Fragments

Make content appear incrementally (similar to incremental lists but for any content):

```markdown
::: {.fragment}
This text appears on click
:::

::: {.fragment}
This appears next
:::
```

### Content Overflow

#### Smaller Text

Use `.smaller` class for slides with more content:

```markdown
## Slide Title {.smaller}

Lots of content that needs to fit on one slide...
```

Global setting:

```yaml
format:
  revealjs:
    smaller: true
```

#### Scrollable Content

Use `.scrollable` class for off-slide content:

```markdown
## Slide Title {.scrollable}

Very long content that can be scrolled...
```

Global setting:

```yaml
format:
  revealjs:
    scrollable: true
    center-title-slide: false  # Required for title slides to be scrollable
```

### Speaker Notes

Add speaker notes visible only in presenter view (press `S` key):

```markdown
## Slide Title

Visible slide content

::: {.notes}
These are speaker notes only visible in presenter view.
Cannot include external dependencies like mermaid diagrams.
Use embedded SVG/PNG instead.
:::
```

### Themes

Quarto provides 11 built-in themes for Reveal.js presentations:

```yaml
format:
  revealjs:
    theme: dark  # or beige, blood, default, dracula, league, moon, night, serif, simple, sky, solarized
```

See [Reveal Themes](https://quarto.org/docs/presentations/revealjs/themes.html) for customization details.

### Asides and Footnotes

#### Asides

Peripheral content in smaller, lighter font at bottom of slide:

```markdown
## Slide Title

Main content

::: aside
Additional commentary of peripheral interest.
:::
```

#### Footnotes

```markdown
## Slide Title

- Green ^[A footnote]
- Brown
- Purple

::: aside
Some additional commentary.
:::
```

Control footnote location:

```yaml
format:
  revealjs:
    reference-location: document  # Footnotes at end, hover to preview
```

### Footer and Logo

Add footer text and logo to all slides:

```yaml
format:
  revealjs:
    logo: logo.png
    footer: "Footer text"
```

Remove footer from specific slide:

```markdown
## No Footer Slide {footer=false}

This slide has no footer
```

Custom footer per slide:

```markdown
## Slide Title

Content

::: footer
Custom footer text for this slide
:::
```

### Code Highlighting

#### Line Highlighting

Highlight specific lines of code:

````markdown
```{.python code-line-numbers="6-8"}
import numpy as np
import matplotlib.pyplot as plt

r = np.arange(0, 2, 0.01)
theta = 2 * np.pi * r
fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
ax.plot(theta, r)
ax.set_rticks([0.5, 1, 1.5, 2])
ax.grid(True)
plt.show()
````

````

Multiple ranges:

```markdown
```{.python code-line-numbers="7,9"}
# Highlights lines 7 and 9
````

````

Progressive highlighting (each step advances):

```markdown
```{.python code-line-numbers="|6|9"}
# Step 1: Show all
# Step 2: Highlight line 6
# Step 3: Highlight line 9
````

````

For executable code cells:

```markdown
```{python}
#| code-line-numbers: "|6|9"

# Your code here
````

````

#### Code Block Height

Control maximum code block height:

```yaml
format:
  revealjs:
    code-block-height: 650px
````

### Executable Code in Slides

#### Figure Sizing

Figures are automatically sized to fill available space, but you can customize:

```python
# Altair example
alt.Chart(cars).mark_point().encode(
    x='Horsepower',
    y='Miles_per_Gallon',
    color='Origin',
).properties(
    width=700,
    height=300
).interactive()
```

#### Code Echo

Code blocks don't echo by default in slides. Enable with:

````markdown
```{python}
#| echo: true

import matplotlib.pyplot as plt
# Your code
````

````

#### Output Location

Control where output appears:

| Option | Behavior |
|--------|----------|
| `fragment` | Output appears as a fragment (on click) |
| `slide` | Output on next slide |
| `column` | Output in adjacent column |
| `column-fragment` | Output in column, revealed as fragment |

Example:

```markdown
```{r}
#| echo: true
#| output-location: slide

library(ggplot2)
ggplot(airquality, aes(Temp, Ozone)) +
  geom_point() +
  geom_smooth(method = "loess")
````

````

### Tabsets

Create tabbed content on slides:

```markdown
::: {.panel-tabset}

### Tab A

Content for Tab A

### Tab B

Content for Tab B

:::
````

**Note**: Only the first tab is visible when printing to PDF.

### Slide Backgrounds

#### Color Backgrounds

```markdown
## Slide Title {background-color="aquamarine"}

Content with colored background
```

#### Gradient Backgrounds

```markdown
## Slide Title {background-gradient="linear-gradient(to bottom, #283b95, #17b2c3)"}

## Slide Title {background-gradient="radial-gradient(#283b95, #17b2c3)"}
```

#### Image Backgrounds

```markdown
## Slide Title {background-image="path/to/image.jpg"}

## Slide Title {background-image="path/to/image.jpg" background-size="contain" background-repeat="no-repeat"}
```

Background image options:

- `background-size`: `cover` (default), `contain`, or specific size
- `background-position`: `center` (default) or other CSS values
- `background-repeat`: `no-repeat` (default), `repeat`, etc.
- `background-opacity`: `0` to `1` (default: `1`)

#### Video Backgrounds

```markdown
## Slide Title {background-video="video.mp4" background-video-loop="true" background-video-muted="true"}

Slide with video background
```

Video options:

- `background-video-loop`: `false` (default) or `true`
- `background-video-muted`: `false` (default) or `true`
- `background-size`: `cover` (default) or `contain`
- `background-opacity`: `0` to `1`

#### IFrame Backgrounds

Embed a webpage as slide background:

```markdown
## Slide Title {background-iframe="https://example.com"}

## Interactive Slide {background-iframe="https://example.com" background-interactive="true"}
```

**Note**: `background-interactive` allows interaction with iframe but prevents interaction with slide content.

#### Slides Without Titles

Background can be applied to slides without titles:

```markdown
## {background-color="aquamarine"}

Content with no title but colored background

## {background-image="image.jpg" background-size="cover"}

Another slide with no title
```

#### Title Slide Background

For the main title slide, use `title-slide-attributes` with `data-` prefix:

```yaml
---
title: My Slide Show
format: revealjs
title-slide-attributes:
    data-background-image: /path/to/title_image.png
    data-background-size: contain
    data-background-opacity: "0.5"
---
```

### Advanced Features

For more advanced capabilities, see:

- **[Presenting Slides](https://quarto.org/docs/presentations/revealjs/presenting.html)**: Navigation, printing to PDF, chalkboard drawing, multiplex presentations
- **[Advanced Reveal](https://quarto.org/docs/presentations/revealjs/advanced.html)**: Transitions, animations, advanced layout and positioning
- **[Reveal Themes](https://quarto.org/docs/presentations/revealjs/themes.html)**: Customizing and creating themes

### Slides Best Practices for This Project

1. **Consistent formatting**: Use level 2 headings (`##`) for individual slides
2. **Section organization**: Use level 1 headings (`#`) to group related slides
3. **Progressive disclosure**: Use incremental lists and fragments for complex content
4. **Image references**: Use `{{< meta params.images_path >}}` for consistent paths
5. **Speaker notes**: Add notes for teaching guidance without cluttering slides
6. **Code highlighting**: Use progressive line highlighting for code walkthroughs
7. **Backgrounds**: Apply backgrounds to title slides and key concept slides
8. **Testing**: Preview with `quarto preview` to ensure timing and flow work well

## Advanced Reveal.js Features

This section covers advanced capabilities for creating sophisticated Reveal.js presentations.

### Slide Transitions

Control animated transitions between slides.

#### Available Transition Types

| Transition | Effect                           |
| ---------- | -------------------------------- |
| `none`     | No transition (instant switch)   |
| `fade`     | Cross fade                       |
| `slide`    | Slide horizontally               |
| `convex`   | Slide at a convex angle          |
| `concave`  | Slide at a concave angle         |
| `zoom`     | Scale incoming slide from center |

#### Global Transitions

```yaml
format:
  revealjs:
    transition: slide
    background-transition: fade
    transition-speed: fast  # default, fast, or slow
```

#### Per-Slide Transitions

```markdown
## Slide Title {transition="fade" transition-speed="fast"}

## Slide Title {transition="fade-in slide-out"}
```

### Slide Visibility

Control which slides are visible and counted.

#### Hidden Slides

```markdown
## Hidden Slide {visibility="hidden"}

This slide is completely hidden from the presentation.
```

#### Uncounted Slides

Useful for optional backup slides that shouldn't affect progress indicators:

```markdown
## Main Content Slide

## Backup Slide 1 {visibility="uncounted"}

## Backup Slide 2 {visibility="uncounted"}
```

### Presentation Size

Control the default resolution and scaling of your presentation.

```yaml
format:
  revealjs:
    width: 1050          # Default normal width
    height: 700          # Default normal height
    margin: 0.1          # Empty space around content (0-1)
    min-scale: 0.2       # Minimum scaling factor
    max-scale: 2.0       # Maximum scaling factor
```

### Absolute Positioning

Position elements precisely on slides using the `.absolute` class.

```markdown
![](image1.png){.absolute top=200 left=0 width="350" height="300"}

![](image2.png){.absolute top=50 right=50 width="450" height="250"}

![](image3.png){.absolute bottom=20 right=100 width="300" height="300"}
```

Position attributes (can use CSS units like `px`, `em`, or just numbers for pixels):

- `width`, `height`: Element dimensions
- `top`, `left`, `bottom`, `right`: Distance from slide edges

**Note**: Default slide size is 1050 x 700 pixels.

### Layout Helpers

#### Stack Layout (`.r-stack`)

Center and stack multiple elements on top of each other (great with fragments):

```markdown
::: {.r-stack}
![](image1.png){.fragment width="450" height="300"}

![](image2.png){.fragment width="300" height="450"}

![](image3.png){.fragment width="400" height="400"}
:::
```

#### Fit Text (`.r-fit-text`)

Make text as large as possible without overflowing:

```markdown
::: {.r-fit-text}
Big Text
:::
```

#### Center (`.center`)

Vertically center slide content:

```markdown
## This Slide is Centered {.center}

All content is vertically centered with proper spacing.
```

#### Stretch (`.r-stretch`)

Resize element to fill remaining vertical space:

```markdown
## Slide Title

Here is an image:

![](image.png){.r-stretch}

Some text after the image.
```

**Auto-stretch behavior**:

- Automatically applied to single top-level images
- Disable globally: `auto-stretch: false`
- Disable per-slide: `{.nostretch}` class
- Disable per-image: `![](image.png){.nostretch}`

**Note**: Auto-stretch doesn't work well with scrollable slides. Either disable it globally and use `.r-stretch` selectively, or add `.nostretch` to scrollable slides.

### Auto-Animate

Automatically animate elements between adjacent slides.

#### Basic Animation

Add `auto-animate=true` to adjacent slides:

```markdown
## {auto-animate=true}

::: {style="margin-top: 100px;"}
Animating content
:::

## {auto-animate=true}

::: {style="margin-top: 200px; font-size: 3em; color: red;"}
Animating content
:::
```

Animatable properties: `position`, `font-size`, `line-height`, `color`, `background-color`, `padding`, `margin`

#### Code Animations

Animate between code blocks:

````markdown
## {auto-animate=true}

```r
# Fill in the spot we created for a plot
output$phonePlot <- renderPlot({
  # Render a barplot
})
````

## {auto-animate=true}

```r
# Fill in the spot we created for a plot
output$phonePlot <- renderPlot({
  # Render a barplot
  barplot(WorldPhones[,input$region]*1000,
          main=input$region,
          ylab="Number of Telephones",
          xlab="Year")
})
```

````

#### Movement Animations

Elements are automatically moved to new positions:

```markdown
## {auto-animate=true}

Animation

## {auto-animate=true}

Implicit

Animation
````

#### Element Matching with data-id

Use `data-id` attributes for explicit matching:

```markdown
## {auto-animate=true auto-animate-easing="ease-in-out"}

::: {.r-hstack}
::: {data-id="box1" auto-animate-delay="0" style="background: #2780e3; width: 200px; height: 150px; margin: 10px;"}
:::

::: {data-id="box2" auto-animate-delay="0.1" style="background: #3fb618; width: 200px; height: 150px; margin: 10px;"}
:::

::: {data-id="box3" auto-animate-delay="0.2" style="background: #e83e8c; width: 200px; height: 150px; margin: 10px;"}
:::
:::

## {auto-animate=true auto-animate-easing="ease-in-out"}

::: {.r-stack}
::: {data-id="box1" style="background: #2780e3; width: 350px; height: 350px; border-radius: 200px;"}
:::

::: {data-id="box2" style="background: #3fb618; width: 250px; height: 250px; border-radius: 200px;"}
:::

::: {data-id="box3" style="background: #e83e8c; width: 150px; height: 150px; border-radius: 200px;"}
:::
:::
```

#### Animation Settings

| Attribute                | Default | Description                                   |
| ------------------------ | ------- | --------------------------------------------- |
| `auto-animate-easing`    | `ease`  | CSS easing function                           |
| `auto-animate-unmatched` | `true`  | Whether unmatched elements fade in            |
| `auto-animate-duration`  | `1.0`   | Animation duration (seconds)                  |
| `auto-animate-delay`     | `0`     | Animation delay (seconds, element-level only) |
| `auto-animate-id`        | -       | Tie auto-animate slides together              |
| `auto-animate-restart`   | -       | Break apart adjacent auto-animate slides      |

Global defaults:

```yaml
format:
  revealjs:
    auto-animate-easing: ease-in-out
    auto-animate-unmatched: false
    auto-animate-duration: 0.8
```

### Advanced Fragments

Beyond basic incremental lists, fragments provide fine-grained control over element appearance.

#### Fragment Classes

| Class                      | Effect                            |
| -------------------------- | --------------------------------- |
| `.fade-out`                | Start visible, fade out           |
| `.fade-up`                 | Slide up while fading in          |
| `.fade-down`               | Slide down while fading in        |
| `.fade-left`               | Slide left while fading in        |
| `.fade-right`              | Slide right while fading in       |
| `.fade-in-then-out`        | Fade in, then out on next step    |
| `.fade-in-then-semi-out`   | Fade in, then to 50% on next step |
| `.grow`                    | Scale up                          |
| `.semi-fade-out`           | Fade out to 50%                   |
| `.shrink`                  | Scale down                        |
| `.strike`                  | Strike through                    |
| `.highlight-red`           | Turn text red                     |
| `.highlight-green`         | Turn text green                   |
| `.highlight-blue`          | Turn text blue                    |
| `.highlight-current-red`   | Turn red, then back to original   |
| `.highlight-current-green` | Turn green, then back to original |
| `.highlight-current-blue`  | Turn blue, then back to original  |

Example:

```markdown
::: {.fragment .fade-out}
Fade out
:::

::: {.fragment .highlight-red}
Highlight red
:::

::: {.fragment .fade-in-then-out}
Fade in, then out
:::

::: {.fragment .fade-up}
Slide up while fading in
:::
```

#### Nested Fragments

Apply multiple fragment effects sequentially:

```markdown
::: {.fragment .fade-in}
::: {.fragment .highlight-red}
::: {.fragment .semi-fade-out}
Fade in > Turn red > Semi fade out
:::
:::
:::
```

#### Fragment Order

Control display order with `fragment-index`:

```markdown
::: {.fragment fragment-index=3}
Appears last
:::

::: {.fragment fragment-index=1}
Appears first
:::

::: {.fragment fragment-index=2}
Appears second
:::
```

#### Custom Fragments

Create custom fragment effects with CSS:

```markdown
::: {.fragment .custom .blur}
First item to be unblurred
:::

::: {.fragment .custom .blur}
Second one to be revealed
:::
```

With CSS:

```css
.reveal .slides section .fragment.blur {
  filter: blur(5px);
}

.reveal .slides section .fragment.blur.visible {
  filter: none;
}
```

### Parallax Background

Create parallax scrolling backgrounds:

```yaml
format:
  revealjs:
    parallax-background-image: background.png
    parallax-background-size: "2100px 900px"
    parallax-background-horizontal: 200  # Optional, default shown
    parallax-background-vertical: 50     # Optional, default shown
```

### Vertical Slides

Create nested vertical slide stacks for hierarchical content.

#### Navigation Modes

| Mode       | Behavior                                             |
| ---------- | ---------------------------------------------------- |
| `linear`   | Left/right arrows step through all slides            |
| `vertical` | Left/right for horizontal, up/down for vertical      |
| `grid`     | Maintains vertical position when moving horizontally |

**Warning**: Vertical slides can confuse users who don't expect them. Use sparingly and consider that distributed presentations may have vertical content missed.

#### Structure

Use level 1 headings for horizontal axis, level 2 for vertical:

```yaml
format:
  revealjs:
    navigation-mode: vertical
```

```markdown
# Slide 1

## Slide 1.1

## Slide 1.2

# Slide 2

## Slide 2.1

## Slide 2.2
```

#### Slide Controls

Configure visual navigation controls:

```yaml
format:
  revealjs:
    navigation-mode: vertical
    controls-layout: bottom-right  # or edges (default)
    controls-tutorial: true         # Show control hints
    controls: false                 # Disable controls entirely
```

**Note**: `controls-layout: bottom-right` conflicts with logo positioning.

### Touch Navigation

Enable/disable swipe navigation on touch devices:

```yaml
format:
  revealjs:
    touch: false
    controls: true  # Recommended when disabling touch
```

### Custom Reveal Plugins

Add third-party Reveal.js plugins by packaging them with a `plugin.yml` configuration file.

#### Plugin Structure

```
myplugin/
├── plugin.yml
└── plugin.js
```

#### Example: Fullscreen Plugin

1. Create `fullscreen/` folder
2. Download plugin JS to `fullscreen/fullscreen.js`
3. Create `fullscreen/plugin.yml`:

```yaml
name: RevealFullscreen
script: [fullscreen.js]
```

4. Reference in presentation:

```yaml
format:
  revealjs:
    revealjs-plugins:
      - fullscreen
```

5. Use in slides:

```markdown
## {fullscreen=true}

<iframe class="stretch" data-src="https://www.google.com/maps/embed?pb=..."></iframe>
```

#### Built-in Plugins

These plugins are already included (no need to add separately):

- **Multiplex**: Multi-device synchronized presentations
- **RevealMenu**: Navigation menu
- **RevealChalkboard**: Drawing on slides
- **PdfExport**: PDF export functionality

### Title Slide Customization

#### Custom Title Slide Background

Already covered in basic slides section, but for reference:

```yaml
title: My Slide Show
format: revealjs
title-slide-attributes:
  data-background-image: /path/to/title_image.png
  data-background-size: contain
  data-background-opacity: "0.5"
```

#### Custom Title Template

Replace the entire title slide with a custom template:

```yaml
title: My Slide Show
format:
  revealjs:
    template-partials:
      - title-slide.html
```

Create `title-slide.html` based on [Quarto's title slide templates](https://github.com/quarto-dev/quarto-cli/blob/main/src/resources/formats/revealjs/pandoc/title-fancy/title-slide.html).

#### Title Slide Centering

Control title slide centering independently:

```yaml
format:
  revealjs:
    center-title-slide: false  # Top-align title slide
```

**Note**: If `center: true` is set globally, `center-title-slide` is ignored.

### Advanced Best Practices

01. **Transitions**: Use subtle transitions (`fade`, `slide`) for professional presentations
02. **Auto-animate**: Great for showing code evolution or concept progression
03. **Fragments**: Prefer fragment classes over basic incremental for varied effects
04. **Absolute positioning**: Use sparingly for precise layouts (diagrams, overlays)
05. **Vertical slides**: Avoid unless absolutely necessary (confusing for users)
06. **Auto-stretch**: Disable globally if using many custom layouts
07. **Touch navigation**: Keep enabled for mobile-friendly presentations
08. **Hidden slides**: Use for presenter-only backup content
09. **Uncounted slides**: Perfect for optional deep-dive slides at the end
10. **Custom plugins**: Only add if built-in features don't meet your needs

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

````python
```{python}
#| eval: true
#| echo: true
import torch
print("Hello World")
````

````

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
````

````

#### Code Execution Options

```python
#| eval: true          # Execute the code
#| echo: true          # Show the code
#| echo: false         # Hide the code
#| output: false       # Hide output
#| warning: false      # Hide warnings
#| message: false      # Hide messages
````

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

01. **Triple colons (`:::`)** for divs instead of HTML div tags
02. **Curly braces with classes** like `{.callout-note}` for styling
03. **Shortcodes** use `{{< >}}` syntax
04. **Cross-references** use `@` prefix (e.g., `@fig-name`, `@tbl-name`)
05. **Code execution** is built-in with `{python}` blocks and `#|` directives
06. **Freeze execution** caches results for faster rebuilds
07. **Attributes order matters**: Must be ID, then classes, then key-value pairs (e.g., `{#id .class key="value"}`)
08. **Lists require blank lines**: Unlike GitHub/Jupyter, lists must have a blank line before them
09. **Spans for styling**: Use `[text]{.class}` for inline styling like `.smallcaps`, `.underline`, `.mark`
10. **Raw content**: Use ````  ```{=format} ```` for format-specific raw content (HTML, LaTeX, Typst)

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

01. **Nested divs require different numbers of colons**: Use `::::` for outer and `:::` for inner
02. **Cross-references need IDs**: Use `{#fig-id}` or `{#tbl-id}` syntax
03. **Reserved prefixes**: Don't use `fig-`, `tbl-`, `lst-`, `tip-`, `nte-`, `wrn-`, `imp-`, `cau-`, `thm-`, `lem-`, `cor-`, `prp-`, `cnj-`, `def-`, `exm-`, `exr-`, `sol-`, `rem-`, `alg-`, `eq-`, `sec-` unless creating cross-references
04. **Avoid underscores in IDs**: Use hyphens instead (underscores cause LaTeX/PDF issues)
05. **Cross-reference IDs must be lowercase**: `#fig-MyPlot` won't work, use `#fig-my-plot`
06. **Images need proper paths**: Use `{{< meta params.images_path >}}` for consistency
07. **Citations need `.bib` entry**: Ensure reference exists in `assets/references.bib`
08. **Code blocks need proper fencing**: Use triple backticks with `{python}` for execution
09. **Table captions**: Use `:` on a new line after the table for captions
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

01. **Use consistent naming**: Prefix figures/tables with topic (e.g., `fig-cnn-`, `tbl-rl-`)
02. **Leverage parameters**: Define `images_path` in YAML front matter
03. **Include LaTeX macros**: Always include `_macros.tex` for consistent math notation
04. **Add learning objectives**: Start lectures with objectives callout
05. **Use collapsible quizzes**: Make practice content collapsible with `collapse="true"`
06. **Provide step-by-step solutions**: Break down complex calculations
07. **Include intuition**: Add "Key Insight" or "Intuition" sections
08. **Cross-reference**: Link between figures, tables, and sections
09. **Cite sources**: Always credit image sources and papers
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

````markdown
```{=html}
<iframe src="https://example.com"></iframe>
````

```{=latex}
\renewcommand*{\labelitemi}{\textgreater}
```

```{=typst}
#set text(fill: red)
```

Inline raw: `Here's some raw inline HTML: <a>html</a>`{=html}

````

### Footnotes

```markdown
Here is a footnote reference,[^1] and another.[^longnote]

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented.
````

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

````markdown
```{mermaid}
flowchart LR
  A[Hard edge] --> B(Round edge)
  B --> C{Decision}
  C --> D[Result one]
  C --> E[Result two]
````

````

### Page Breaks

```markdown
page 1

{{< pagebreak >}}

page 2
````

## Cross-Reference Variations

### Reference Syntax Options

| Syntax        | Example                    | Output                |
| ------------- | -------------------------- | --------------------- |
| Default       | `@fig-elephant`            | "Figure 1"            |
| Capitalized   | `@Fig-elephant`            | "Figure 1"            |
| Custom prefix | `[Fig @fig-elephant]`      | "Fig 1"               |
| No prefix     | `[-@fig-elephant]`         | "1"                   |
| Multiple      | `[@fig-a; @fig-b; @fig-c]` | "Figures 1, 2, and 3" |

### Subfigures Auto-naming

When using `fig-subcap`, subfigure labels are automatically created:

- Main label: `#fig-plots`
- Subfigure 1: `@fig-plots-1`
- Subfigure 2: `@fig-plots-2`

Same for subtables: `@tbl-panel-1`, `@tbl-panel-2`

### Cross-Reference Prefixes

| Type              | Prefix  | Example            |
| ----------------- | ------- | ------------------ |
| Figure            | `#fig-` | `#fig-diagram`     |
| Table             | `#tbl-` | `#tbl-results`     |
| Equation          | `#eq-`  | `#eq-quadratic`    |
| Section           | `#sec-` | `#sec-intro`       |
| Code Listing      | `#lst-` | `#lst-algorithm`   |
| Theorem           | `#thm-` | `#thm-pythagorean` |
| Lemma             | `#lem-` | `#lem-helper`      |
| Definition        | `#def-` | `#def-derivative`  |
| Note callout      | `#nte-` | `#nte-important`   |
| Tip callout       | `#tip-` | `#tip-performance` |
| Warning callout   | `#wrn-` | `#wrn-danger`      |
| Important callout | `#imp-` | `#imp-security`    |
| Caution callout   | `#cau-` | `#cau-breaking`    |

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

````python
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
````

````

### Output Options

```python
#| output: false      # Hide all output
#| output: true       # Show output (default)
#| output: asis       # Raw markdown output (no Quarto div wrapping)
````

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

````python
```{python}
#| label: fig-output          # For the figure
#| fig-cap: "Figure caption"
#| lst-label: lst-code        # For the code itself
#| lst-cap: "Code caption"

plt.plot([1,2,3,4])
plt.show()
````

Reference as: @lst-code produces @fig-output.

````

### Jupyter-Specific Options

```yaml
---
ipynb-shell-interactivity: all  # Print all expressions (default: last_expr)
---
````

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

| Task                | Syntax                                              |
| ------------------- | --------------------------------------------------- |
| Callout box         | `::: {.callout-type}` ... `:::`                     |
| Figure with ID      | `:::{#fig-id}` ... `:::`                            |
| Reference figure    | `@fig-id`                                           |
| Custom reference    | `[Fig @fig-id]` (custom prefix)                     |
| No-prefix reference | `[-@fig-id]` (number only)                          |
| Multiple references | `[@fig-a; @fig-b; @fig-c]`                          |
| Include file        | `{{< include path >}}`                              |
| Meta parameter      | `{{< meta params.name >}}`                          |
| Math equation       | `\begin{equation}` ... `\end{equation}`             |
| Equation with label | `$$ ... $$ {#eq-label}`                             |
| Python code         | ````  ```{python} ```` ... ```` ``` ````            |
| Unexecuted code     | ````  ```{{python}} ```` ... ```` ``` ````          |
| Citation            | `@citation_key`                                     |
| Multiple citations  | `[@cite1; @cite2]`                                  |
| Collapsible         | `<details><summary>` ... `</summary></details>`     |
| Video embed         | `{{< video url >}}`                                 |
| Page break          | `{{< pagebreak >}}`                                 |
| Keyboard shortcut   | `{{< kbd Ctrl-C >}}`                                |
| Two columns         | `:::: {.columns}` with `:::  {.column width="50%"}` |
| Span with class     | `[text]{.smallcaps}`                                |
| Raw HTML            | ````  ```{=html} ```` ... ```` ``` ````             |
| Inline footnote     | `text^[footnote content]`                           |
| Diagram (Mermaid)   | ````  ```{mermaid} ```` ... ```` ``` ````           |

______________________________________________________________________

**Last Updated**: October 1, 2025
**Maintainer**: AI Assistant for CAS Deep Learning Project
