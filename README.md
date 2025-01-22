# Enterprise-Control-Language (ECL) Project by LexisNexis

## Overview

This repository contains the implementation of research titled **"Model Inversion Attacks and Prevention Tactics Using the HPCC Systems Platform."** The project focuses on analyzing and mitigating model inversion attacks in machine learning, particularly in the financial domain. The study uses the HPCC Systems platform for large-scale data processing and demonstrates defensive mechanisms to enhance model security while preserving utility.

---

## Features

- **Preprocessing Pipeline**: Handles financial loan datasets, including masking and categorization for privacy.
- **Original Model**: Logistic Regression implementation for predicting loan repayment outcomes.
- **Attack Model**: Simulates black-box model inversion attacks by querying the original model.
- **Prevention Model**: Implements noise addition to reduce attack success rates while maintaining data utility.
- **HPCC Systems Integration**: Utilizes the ECL language and client tools for efficient data processing and monitoring.

---

## Prerequisites

1. **HPCC Systems Platform**: Install the latest version from [HPCC Systems](https://hpccsystems.com/download).
2. **ECL Client Tools**: Set up for writing, compiling, and monitoring ECL code.
3. **Visual Studio Code**: Recommended IDE for ECL, particularly for macOS users.
4. **Kaggle Dataset**: Download the [loan dataset](https://www.kaggle.com/datasets/ethon0426/lending-club-20072020q1/code) used in this project.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Andrew22122001/Enterprise-Control-Language-Project-by-LexisNexis.git
   cd Enterprise-Control-Language-Project-by-LexisNexis
