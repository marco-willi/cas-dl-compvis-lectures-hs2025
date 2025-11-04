# Claude Code Reference - Computer Vision Course Project

This document provides essential information for AI assistants (like Claude Code) working on this project.

## Project Overview

This is a **Quarto-based GitPages website** for a **2-day computer vision course** focused on deep learning. The course emphasizes building intuition about how deep learning works for computer vision applications.

**Topics Covered:**

- Introduction to computer vision and deep learning
- Convolutional Neural Networks (CNNs)
- Foundation models and representation learning
- Image classification
- Practical implementation guidelines

**Technology Stack:**

- **Quarto** for documentation and lecture content
- **Jupyter notebooks** (.ipynb) for interactive demonstrations
- **Python** with PyTorch/TensorFlow for code examples
- **GitHub Pages** for hosting

**Companion Materials:**

- Separate GitHub repository with exercises (not included here)

## Quick Start

### Building the Website

```bash
make render          # Render the entire website
quarto preview       # Live preview with auto-reload
quarto render        # Alternative render command
```

### Project Configuration

- Main config: `_quarto.yml`
- Environment variables: `_environment.local` (gitignored)
- LaTeX macros: `assets/_macros.tex`
- Bibliography: `assets/references.bib`

## Quarto Documentation

**IMPORTANT:** For comprehensive Quarto syntax, features, and best practices, see **`QUARTO.md`**.

Key topics in QUARTO.md:

- Quarto syntax reference (callouts, figures, tables, math, code)
- Creating Reveal.js slides (basic and advanced features)
- Document formatting and cross-referencing
- Citations and bibliography
- Code execution options
- Project-specific patterns and examples

## Project Structure

### Directory Organization

```
/workspace/
├── _quarto.yml              # Main Quarto configuration
├── index.qmd                # Homepage/landing page
├── pages/                   # All content pages
│   ├── lectures/            # Main lecture content (.qmd)
│   │   ├── intro.qmd
│   │   ├── classification.qmd
│   │   ├── cnns.qmd
│   │   ├── foundation_models.qmd
│   │   ├── practical.qmd
│   │   ├── recent_advances.qmd
│   │   └── representation_learning.qmd
│   ├── background/          # Foundational concepts
│   │   ├── machine_learning.qmd
│   │   ├── neural_networks.qmd
│   │   └── frameworks.qmd
│   ├── slides/              # Presentation versions
│   └── misc/                # Additional materials
├── demos/                   # Jupyter notebooks (not rendered by default)
│   ├── classification/
│   ├── genai/
│   ├── intro/
│   ├── representation_learning/
│   └── *.ipynb              # Various demo notebooks
├── assets/                  # Static assets
│   ├── images/              # Organized by topic
│   │   ├── classification/
│   │   ├── cnns/
│   │   ├── intro/
│   │   ├── representation_learning/
│   │   └── genai/
│   ├── _macros.tex          # LaTeX macros for math notation
│   └── references.bib       # Bibliography
├── _output/                 # Rendered HTML (gitignored)
└── Documentation
    ├── AGENTS.md            # Detailed project structure guide
    ├── QUARTO.md            # Comprehensive Quarto reference
    ├── CLAUDE.md            # This file
    └── NOTES.md             # Development notes
```

### File Organization Principles

1. **Lecture Content** (`pages/lectures/`): Main educational content in Quarto (.qmd) format
2. **Demo Notebooks** (`demos/`): Interactive Jupyter notebooks for generating assets
3. **Assets** (`assets/`): All static resources organized by topic
4. **Output** (`_output/`): Rendered website (auto-generated, not committed)

## Creating Demonstration Notebooks

### Location and Organization

Demonstration notebooks should be placed in the `demos/` directory, organized by topic:

```
demos/
├── classification/
│   └── generate_cats_dogs.ipynb
├── genai/
│   ├── generate_sde_samples.ipynb
│   ├── simulate_gen_1d.ipynb
│   └── simulate_gen_2d.ipynb
├── intro/
│   └── semantic_gap.ipynb
├── representation_learning/
│   ├── generate_augmented_examples.ipynb
│   ├── generate_example_images.ipynb
│   └── supervised_rl.ipynb
└── [topic-specific notebooks at root level]
```

### Critical Rule: Data Output Conventions

**All generated data, images, and assets MUST be saved to the `assets/` directory** to be accessible by Quarto pages.

#### Output Directory Structure

1. **Images**: `assets/images/{topic}/`

   - Example: `assets/images/classification/cats_and_dogs/`
   - Example: `assets/images/cnns/filters/`
   - Example: `assets/images/representation_learning/features/`

2. **Datasets**: `assets/data/{topic}/`

   - Example: `assets/data/classification/benchmark_results.csv`

3. **Models**: `assets/models/{topic}/`

   - Example: `assets/models/classification/resnet50_pretrained.pth`

4. **Processed Results**: `assets/results/{topic}/`

   - Example: `assets/results/experiments/accuracy_comparison.json`

### Notebook Template

Every demonstration notebook should follow this structure:

```python
# Markdown Cell
"""
# [Descriptive Title]

Brief description of what the notebook demonstrates.

**Output:**
- List of generated assets
- Where they are saved

**Requirements:**
- Required packages
- API keys or environment variables
- Hardware requirements (if any)
"""

# Markdown Cell
"""
## Setup and Imports
"""

# Code Cell
import os
from pathlib import Path
# Other imports...

# Load environment variables if needed
from dotenv import load_dotenv
load_dotenv('/workspace/_environment.local')

# Setup output directory in assets/
OUTPUT_DIR = Path('/workspace/assets/images/{topic}/{specific_use_case}')
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

print(f"✓ Setup complete")
print(f"✓ Output directory: {OUTPUT_DIR}")
```

### Example: Output Directory Setup

From `demos/classification/generate_cats_dogs.ipynb`:

```python
# Setup output directory - ALWAYS use assets/ structure
OUTPUT_DIR = Path('/workspace/assets/images/classification/cats_and_dogs')
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Generate and save images
for i, prompt in enumerate(cat_prompts, 1):
    output_path = OUTPUT_DIR / f"cat_{i:02d}.png"
    generate_and_save_image(prompt, output_path)
```

### Environment and API Keys

- Store sensitive information in `_environment.local` (gitignored)
- Use `python-dotenv` to load environment variables
- Common environment variables:
  - `REPLICATE_API_KEY`: For image generation
  - `OPENAI_API_KEY`: For GPT models
  - `HUGGINGFACE_TOKEN`: For model downloads

### Notebook Best Practices

1. **Clear Documentation**: Self-contained with clear explanations
2. **Error Handling**: Include try-catch blocks for API calls
3. **Progress Indicators**: Use progress bars or print statements
4. **Resource Management**: Clean up temporary files
5. **Reproducibility**: Set random seeds where appropriate
6. **Skip Logic**: Check if outputs exist before regenerating

### Integration with Quarto Pages

Once assets are generated in `assets/`, reference them in Quarto pages:

```markdown
![Generated Cat]({{< meta params.images_path >}}cats_and_dogs/cat_01.png){width=200}

<!-- Or in a quiz/example -->
::: {.callout-note title="Generated Examples"}
![Cat]({{< meta params.images_path >}}cats_and_dogs/cat_01.png){width=80}
![Dog]({{< meta params.images_path >}}cats_and_dogs/dog_01.png){width=80}
:::
```

## Working with Quarto Content

### Standard Lecture Structure

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

### Key Quarto Features Used

1. **Callouts**: `.callout-note`, `.callout-tip`, `.callout-important`, `.callout-warning`
2. **Images**: Use `{{< meta params.images_path >}}` for consistent paths
3. **Math**: Include LaTeX macros from `assets/_macros.tex`
4. **Cross-references**: Use `@fig-id`, `@tbl-id`, `@eq-id`
5. **Citations**: Use `@citation_key` from `references.bib`
6. **Code Execution**: Python code blocks with `{python}` and `#|` options

### Page Metadata Pattern

```yaml
---
title: "4 - Convolutional Neural Networks"
params:
   images_path: "/assets/images/cnns/"
---
```

**Note**: Lectures have numbered titles; slides do not.

## Development Workflow

### Typical Workflow

1. **Content Creation**: Write/edit lecture content in `pages/lectures/`
2. **Asset Generation**: Create notebooks in `demos/` to generate supporting assets
3. **Asset Integration**: Reference generated assets in lecture content using `params.images_path`
4. **Testing**: Use `quarto render` or `quarto preview` to test
5. **Deployment**: Rendered site in `_output/` ready for GitHub Pages

### Quality Guidelines

The goal is to make lecture notes **concise, correct, current, and engaging**:

- **Concise**: Remove redundant information, focus on key concepts
- **Correct**: Verify mathematical formulations and code examples
- **Current**: Use modern techniques and recent references
- **Engaging**: Include interactive elements, quizzes, and visual examples

## Common Tasks

### Creating a New Lecture

1. Create new `.qmd` file in `pages/lectures/`
2. Add YAML header with title and `params.images_path`
3. Include learning objectives callout
4. Include LaTeX macros
5. Add to navigation in `_quarto.yml`
6. Create corresponding image directory in `assets/images/`

### Creating a New Demo Notebook

1. Create new `.ipynb` in `demos/[topic]/`
2. Add header cell with description and requirements
3. Setup output directory pointing to `assets/`
4. Generate assets
5. Reference assets in corresponding lecture `.qmd`

### Adding Images

1. Generate images via notebook or add manually to `assets/images/[topic]/`
2. Reference in `.qmd` using:
   ```markdown
   ![Alt text]({{< meta params.images_path >}}image_name.png){width=400}
   ```
3. For cross-referenced figures:
   ```markdown
   :::{#fig-example-id}
   ![]({{< meta params.images_path >}}image.png)

   Caption text here
   :::
   ```

### Adding Citations

1. Add BibTeX entry to `assets/references.bib`
2. Use in text with `@citation_key`
3. Add references section at end of document

## Common Issues and Solutions

1. **Image Paths**: Always use relative paths from `assets/` and the `params.images_path` variable
2. **Large Files**: Use `.gitignore` for large generated assets; provide regeneration notebooks
3. **Environment Setup**: Document all dependencies in notebook headers
4. **Cross-References**: Use Quarto's cross-referencing system for figures and equations
5. **Build Errors**: Check `_quarto.yml` render patterns; some files/directories are excluded

## Tips for AI Assistants

### When Creating Content

1. **Always check QUARTO.md** for syntax reference
2. **Follow existing patterns** in `pages/lectures/` for consistency
3. **Use proper asset paths** pointing to `assets/` directory
4. **Include LaTeX macros** for mathematical notation
5. **Add learning objectives** at the start of lectures
6. **Provide step-by-step solutions** for quizzes and exercises

### When Creating Notebooks

1. **Output to assets/**: Never output to `demos/` or other directories
2. **Document clearly**: Include requirements and output description
3. **Handle errors gracefully**: API calls, file operations, etc.
4. **Show progress**: Long-running operations should indicate progress
5. **Set random seeds**: For reproducibility

### When Modifying Structure

1. **Update `_quarto.yml`**: If adding/moving pages
2. **Maintain organization**: Keep topic-based directory structure
3. **Update navigation**: Sidebar and section structure
4. **Test rendering**: Always test with `quarto preview` before committing

## Additional Resources

- **AGENTS.md**: Detailed project structure and conventions
- **QUARTO.md**: Comprehensive Quarto syntax and features reference
- **NOTES.md**: Development notes and project history
- **Official Quarto Docs**: https://quarto.org/docs/guide/

## Current Status

- **Main Branch**: `main`
- **Current Branch**: `genai` (as of this writing)
- **Build Output**: `_output/` directory
- **Recent Work**: GenAI content additions

______________________________________________________________________

**Last Updated**: 2025-11-04
**Purpose**: Quick reference for AI assistants working on this project
