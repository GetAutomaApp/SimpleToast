// LinuxMain.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the APache 2.0 License.
// This Package is a modified fork of https://github.com/sanzaru/SimpleToast

import XCTest

import SimpleToastTests

/// tests var
public var tests = [XCTestCaseEntry]()
tests += SimpleToastTests.allTests()
XCTMain(tests)
