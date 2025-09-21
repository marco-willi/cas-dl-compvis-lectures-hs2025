# Agents code

## Project Overview

This project represents a GitPage for a 2-day course on computer vision with deep learning. The focus is on providing a good intuition about how deep learning works for computer vision. This project is about an introduction ot the topic, convolutional neural networks, foundation models, image classification, and practical guidelines. A separate part, not covered here, concerns object detection and image segmentation.

The proejct is based on quarto and accompanied by a separate GitHub repository with exercises.

## Relevant Files

The most relevant files for this project are:

- ./lectures: folder containing the lecture files in Quarto format (.qmd)
- ./images: folder containing images used in the lectures
- ./\_quarto.yml: Quarto configuration file
- ./slides: folder containing slide files in Quarto format (.qmd)
- ./pages: folder containing additional pages in Quarto format (.qmd)
- ./index.qmd: main index file for the GitPage
- AGENTS.md: this file, describing the agents used in the project

## Step 1 - Review Existing Files

Given the ./lectures folder, review the existing lecture files in Quarto format (.qmd). Identify areas for improvement in terms:

- content accuracy and completeness
- clarity and readability
- engagement and interactivity
- visual appeal and layout

## Step 2 - Foundation models

Suggest a way to include an updated section or whole new file for "foundation_models".

Take into account the "recent_advances.qmd" content.

Prominently place content about Dinov3 into the lecture and reason about it's importance for transfer-learning.

## Quarto

The quarto syntax is not identical to markdown but similar. To avoid mistakes navigate to https://quarto.org/docs/guide/ and read the docs if necessary.

## Building the Project

use the following command to build the project:

```bash
quarto render
```
