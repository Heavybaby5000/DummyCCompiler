## 概要
[![C/C++ CI](https://github.com/Heavybaby5000/DummyCCompiler/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/Heavybaby5000/DummyCCompiler/actions/workflows/c-cpp.yml)
* LLVMのフロントエンド作成のExampleとして作成したLLVMのDummyC用フロントエンド
* DummyCのソースコードをLLVM-IRに変換・出力


## DummyCって？
* 今回のフロントエンド作成用に勝手に定義したC言語のサブセット
* 機能はかなり縮小
* 詳細は[dummyC_ebnf.txt](dummyC_ebnf.txt)を参照


## 基本方針
* 正しい構文を受け入れることを優先
* 誤ったコードに対するエラー処理は深く考えない


## 動作環境
* 下記環境で動作確認してます
  * OS　：Ubuntu 20.04
  * LLVM：LLVM 10.0
  * g++ ：g++ 9.3.0
