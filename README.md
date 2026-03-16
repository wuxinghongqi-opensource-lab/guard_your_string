# guard_your_string
guard_your_string


# guard_your_string
**字符串保护工具 | String Protection Tool**

## 项目介绍 | Project Introduction
`guard_your_string` 是一款轻量级字符串加密保护工具，提供三级权限加密方案，适配普通用户、VIP、SVIP 不同使用场景，支持多字符类型处理，兼顾易用性与安全性。
`guard_your_string` is a lightweight string encryption & protection tool, providing three-level permission encryption solutions for regular users, VIP, and SVIP scenarios. It supports multiple character types, balancing usability and security.

---

## 核心模块 | Core Modules
### 1. 01_guard_your_string_for_user
| 项          | 中文说明                | English Description          |
|-------------|-------------------------|------------------------------|
| 适用对象    | 普通用户                | For: Regular Users           |
| 参数要求    | 1 个参数（待加密字符串） | Params: 1 parameter (string to encrypt) |
| 字符支持    | ✅ 支持中文              | Support: ✅ Chinese supported |
| 核心特点    | 基础加密，开箱即用      | Feature: Basic encryption, ready to use |

### 2. 02_guard_your_string_for_VIP
| 项          | 中文说明                          | English Description                  |
|-------------|-----------------------------------|--------------------------------------|
| 适用对象    | VIP 用户                          | For: VIP Users                       |
| 参数要求    | 2 个参数（待加密字符串 + 偏移量） | Params: 2 parameters (string + offset) |
| 字符支持    | ❌ 不支持中文                      | Support: ❌ Chinese NOT supported     |
| 核心特点    | 偏移量加密，安全性升级            | Feature: Offset-based encryption, enhanced security |

### 3. 03_guard_your_string_for_SVIP
| 项          | 中文说明                          | English Description                  |
|-------------|-----------------------------------|--------------------------------------|
| 适用对象    | SVIP 用户                         | For: SVIP Users                      |
| 参数要求    | 2 个参数（待加密字符串 + 密钥）   | Params: 2 parameters (string + key)   |
| 字符支持    | ✅ 密钥支持中文，字符串无限制      | Support: ✅ Key supports Chinese, no string restrictions |
| 核心特点    | 自定义密钥，最高安全级别          | Feature: Custom key, highest security level |

---
