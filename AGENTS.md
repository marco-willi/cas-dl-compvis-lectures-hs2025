# Agents Code

## Project Overview

This project represents a GitPage for a 2-day course on computer vision with deep learning. The focus is on providing a good intuition about how deep learning works for computer vision. This project covers introduction to the topic, convolutional neural networks, foundation models, image classification, and practical guidelines. A separate part, not covered here, concerns object detection and image segmentation.

The project is based on Quarto and accompanied by a separate GitHub repository with exercises.

## Project Structure

The project follows a well-organized structure optimized for educational content delivery:

### Core Content (`pages/`)

- **`pages/lectures/`**: Main lecture content in Quarto format (.qmd)

  - `intro.qmd`: Course introduction and motivation
  - `classification.qmd`: Image classification fundamentals
  - `cnns.qmd`: Convolutional Neural Networks
  - `foundation_models.qmd`: Modern foundation models
  - `practical.qmd`: Practical implementation guidelines
  - `recent_advances.qmd`: Latest developments
  - `representation_learning.qmd`: Feature learning concepts

- **`pages/background/`**: Foundational concepts and prerequisites

  - `machine_learning.qmd`: ML fundamentals with linear regression examples
  - `neural_networks.qmd`: Basic neural network concepts
  - `frameworks.qmd`: Deep learning frameworks overview

- **`pages/slides/`**: Presentation versions of lectures

- **`pages/misc/`**: Additional supporting materials

### Supporting Infrastructure

- **`assets/`**: All static assets (images, references, etc.)

  - `assets/images/`: Organized by topic (classification/, cnns/, etc.)
  - `assets/_macros.tex`: LaTeX macros for mathematical notation
  - `assets/references.bib`: Bibliography file

- **`demos/`**: Interactive Jupyter notebooks for hands-on examples

- **`_quarto.yml`**: Main Quarto configuration file

- **`index.qmd`**: Landing page for the GitPage

## Creating Demonstration Notebooks

### Notebook Organization

Demonstration notebooks should be placed in the `demos/` directory, organized by topic:

```
demos/
├── classification/
│   ├── generate_cats_dogs.ipynb
│   └── metrics_visualization.ipynb
├── cnns/
│   ├── filter_visualization.ipynb
│   └── architecture_comparison.ipynb
├── representation_learning/
│   └── feature_analysis.ipynb
└── _metadata.yaml
```

### Data Output Conventions

**Critical Rule**: All generated data, images, and assets must be saved to the `assets/` directory structure to be accessible by Quarto pages.

#### Example from `demos/classification/generate_cats_dogs.ipynb`:

```python
# Setup output directory - ALWAYS use assets/ structure
OUTPUT_DIR = Path('/workspace/assets/images/classification/cats_and_dogs')
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Generate and save images
for i, prompt in enumerate(cat_prompts, 1):
    output_path = OUTPUT_DIR / f"cat_{i:02d}.png"
    generate_and_save_image(prompt, output_path)
```

#### Data Output Guidelines:

1. **Images**: Save to `assets/images/{topic}/` subdirectories

   - Example: `assets/images/classification/cats_and_dogs/`
   - Example: `assets/images/cnns/filters/`
   - Example: `assets/images/representation_learning/features/`

2. **Datasets**: Save to `assets/data/{topic}/`

   - Example: `assets/data/classification/benchmark_results.csv`

3. **Models**: Save to `assets/models/{topic}/`

   - Example: `assets/models/classification/resnet50_pretrained.pth`

4. **Processed Results**: Save to `assets/results/{topic}/`

   - Example: `assets/results/experiments/accuracy_comparison.json`

### Notebook Structure Template

Every demonstration notebook should follow this structure:

```xml
<VSCode.Cell language="markdown">
# [Descriptive Title]

Brief description of what the notebook demonstrates.

**Output:**
- List of generated assets
- Where they are saved

**Requirements:**
- Required packages
- API keys or environment variables
- Hardware requirements (if any)
</VSCode.Cell>

<VSCode.Cell language="markdown">
## Setup and Imports
</VSCode.Cell>

<VSCode.Cell language="python">
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
</VSCode.Cell>
```

### Environment and API Keys

- Store sensitive information in `_environment.local` (gitignored)
- Use `python-dotenv` to load environment variables
- Example environment variables:
  - `REPLICATE_API_KEY`: For image generation
  - `OPENAI_API_KEY`: For GPT models
  - `HUGGINGFACE_TOKEN`: For model downloads

### Notebook Best Practices

1. **Clear Documentation**: Each notebook should be self-contained with clear explanations
2. **Error Handling**: Include try-catch blocks for API calls and file operations
3. **Progress Indicators**: Use progress bars or print statements for long-running operations
4. **Resource Management**: Clean up temporary files and close connections
5. **Reproducibility**: Set random seeds where appropriate
6. **Skip Logic**: Include logic to skip regeneration if outputs already exist

### Integration with Quarto Pages

Once assets are generated in the correct `assets/` structure, they can be referenced in Quarto pages:

```markdown
![Generated Cat]({{< meta params.images_path >}}cats_and_dogs/cat_01.png){width=200}

<!-- Or in a quiz/example -->
::: {.callout-note title="Generated Examples"}
![Cat]({{< meta params.images_path >}}cats_and_dogs/cat_01.png){width=80}
![Dog]({{< meta params.images_path >}}cats_and_dogs/dog_01.png){width=80}
:::
```

## Quarto Configuration

The project uses Quarto for rendering. Key configuration details:

- Main config: `_quarto.yml`
- Page metadata: Set `params.images_path` for consistent image references
- Building: Use `make render` or `quarto render`
- Development: Use `quarto preview` for live reload

## Development Workflow

1. **Content Creation**: Write lecture content in `pages/lectures/`
2. **Asset Generation**: Create supporting notebooks in `demos/`
3. **Asset Integration**: Reference generated assets in lecture content
4. **Testing**: Use `quarto render` to test the complete pipeline
5. **Deployment**: The rendered site is ready for GitHub Pages or similar

## Quality Guidelines

The goal is to make lecture notes concise, correct, current, and engaging:

- **Concise**: Remove redundant information, focus on key concepts
- **Correct**: Verify mathematical formulations and code examples
- **Current**: Use modern techniques and recent references
- **Engaging**: Include interactive elements, quizzes, and visual examples

## Common Issues and Solutions

1. **Image Paths**: Always use relative paths from `assets/` and the Quarto `params.images_path` variable
2. **Large Files**: Use `.gitignore` for large generated assets, provide regeneration notebooks
3. **Environment Setup**: Document all dependencies in notebook headers
4. **Cross-References**: Use Quarto's cross-referencing system for figures and equations
