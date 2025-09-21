# Project TODO

This file tracks the enhancement tasks for the CAS Deep Learning Computer Vision lecture site.

## Completed

- [x] Intro updates — Learning objectives, typos fixed (technology, agriculture, similarly), timeline/table, recap.
- [x] Frameworks updates — Manual gradient derivative fix, tensor creation formatting cleanup, DataLoader note, learning objectives & recap.
- [x] Neural networks updates — Learning objectives, activation cheat sheet callout, notation clarification, recap.
- [x] CNNs updates — Typos, corrected convolution output formula, quiz, learning objectives, recap.

## In Progress / Pending

- [ ] Classification updates
  - Fix softmax denominator indices (ensure Σ over j=1..K) — partially addressed, confirm.
  - Add architecture comparison table (ConvNet vs ResNet vs ViT vs ConvNeXt vs Hybrid).
  - Add quiz block (decision boundaries / calibration) and label smoothing note.
  - Ensure learning objectives & recap present.
- [ ] Practical updates
  - Add diagnostics cheat sheet (overfit/underfit signals, LR pathologies, gradient issues).
  - Insert learning objectives at top; recap near end before references.
  - Minor typo and consistency fixes (capitalization, spacing, code fences labels).
- [ ] Recent advances updates
  - Fix typos (Transfomers → Transformers, mutliple → multiple, similarly, etc.).
  - Add foundation model comparison table (CLIP, DINO v2/v3, SAM, Grounding DINO, BLIP-2, Stable Diffusion) with: modality, pretraining objective, strengths, limitations, typical downstream uses.
  - Add pipeline exercise prompt ("Given task X choose model(s) and justify").
  - Insert learning objectives & recap sections.
- [ ] Quality pass
  - Verify no syntax/render issues in updated .qmd files (callout fences, math blocks, tables).
  - Ensure every lecture has Learning Objectives near top & Recap before references.
  - Consistent capitalization: "deep learning" (generic), Architecture names (ResNet, ViT, ConvNeXt), Dataset names (ImageNet, CIFAR-10).
- [ ] Verify CNNs vs Transformers discussion
  - Review claims across `lectures/cnns.qmd`, `lectures/classification.qmd`, `lectures/recent_advances.qmd`.
  - Ensure coverage of: inductive biases (locality, translation equivariance), data & compute scaling, parameter efficiency, attention variants (windowed, convolutional hybrids), training stability, positional embeddings.
  - Update with 2024–2025 context: hybrid Conv-Attention blocks, "token merging"/pooling advances, efficient attention (FlashAttention), emergence of ConvNeXt-v2, ViT scaling laws, DINO v3 improvements.
- [ ] Review convolution output size example
  - Inspect formula and numeric example in `lectures/cnns.qmd` for output size: confirm floor operation with stride & dilation; adjust example or explanation if mismatch.
  - Add a small explicit numeric worked example (input 32, kernel 3, stride 2, padding 1, dilation 1 → output 16) to reinforce.
- [ ] Refactor quiz visibility
  - Change quiz blocks so questions are always visible while answers are hidden (e.g., <details>Answer</details> or a callout with `collapse=true`).
  - Apply consistent pattern across all current quiz locations (at least CNNs lecture) and future ones.

## Notes / Nice-to-Have (Future)

- Interactive embedding explorer for DINO/CLIP (panel/pyodide or precomputed JSON vectors + scatterplot).
- Attention rollout visualization snippet (small ViT on sample image) for classification lecture.
- Lightweight SAM mask demo (static example with explanation due to model size constraints).
- Add label smoothing & temperature scaling mini-demo in classification.

______________________________________________________________________

Last updated: 2025-09-21 (added conv output size & quiz visibility tasks)
