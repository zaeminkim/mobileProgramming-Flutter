# 미니프로젝트

## 프로젝트명: Outfeed

## 프로그램 개요

Outfeed는 사용자가 소셜 미디어 알고리즘에 의해 형성된 에코 챔버(Echo Chamber)에서 벗어날 수 있도록 돕는 Flutter 기반 소셜 가이드 애플리케이션입니다. 사용자의 콘텐츠 소비 패턴을 분석하여 편향도를 측정하고, 의도적으로 사용자 취향과 반대되는 콘텐츠를 제공함으로써 정보의 불균형을 해소하고 더 넓은 시각을 가질 수 있도록 기획되었습니다.

## 주요 기능 설명

### 1. 알고리즘 오염도(편향도) 분석

- 사용자의 시청 기록 및 좋아요 데이터를 기반으로 현재 알고리즘의 편향성을 분석합니다.
- 지루한 그래프 대신 네온 조각들이 퍼져나가는 창의적인 비주얼로 분석 결과를 시각화합니다.
- 점수와 함께 "정보 다양성 낮음"과 같은 직관적인 한 줄 평과 점수를 제공합니다.

### 2. 알고리즘 탈출 피드

- 사용자의 기존 취향과 정반대되는 카테고리의 콘텐츠를 추천하는 핵심 기능입니다.
- 틱톡/릴스 스타일의 전체 화면 세로 스와이프 인터페이스를 제공합니다.
- 각 콘텐츠마다 현재 알고리즘과 얼마나 차이가 있는지 보여주는 '취향 반전도' 게이지를 표시합니다.

### 3. 알고리즘 정체성 공유 및 교환

- 자신의 알고리즘 분석 결과를 QR 코드 또는 인스타그램 스토리로 즉시 공유할 수 있습니다.
- 앱 내 커뮤니티를 통해 다른 사용자의 알고리즘을 탐험하거나 24시간 동안 서로의 피드를 교환하여 체험할 수 있습니다.

## 본인이 구현한 부분

- UI/UX 시스템 설계: '네온 탈출' 컨셉에 맞춘 다크 모드 기반 디자인 시스템 및 테마 구축
- 프런트엔드 아키텍처: Flutter 프레임워크를 이용한 메인 구조 및 플로팅 네비게이션 바 구현
- 피드 인터페이스: PageView를 활용한 고성능 세로 스크롤 피드 및 오버레이 UI 개발
- 데이터 시각화 위젯: CustomPainter를 활용한 창의적인 네온 스타일 분석 결과 위젯 구현

## AI 활용 여부 및 활용 범위 (Vibe Coding)

앱 아이콘: 앱 아이콘 초안을 가지고 Gemini 3.1과의 협업을 통해 제작  
프로젝트 UI: Claude Opus 4.6과의 협업을 통해 제작된 바이브 코딩(Vibe Coding) 결과물입니다.

- 기획 및 브레인스토밍: 앱의 핵심 가치 정의 및 '네온 탈출' 디자인 컨셉 구체화
- 코드 생성 및 최적화: Flutter 위젯 구조 설계, 복잡한 레이아웃 구현 및 다트(Dart) 코드 생성
- 문제 해결 및 디버깅: 빌드 오류 분석, 환경 설정 가이드 수신 및 성능 최적화 로직 적용
- 방식: 상세 프롬프트를 통해 앱의 의도와 감성을 AI에 전달하고, 생성된 코드를 직접 검토 및 통합하는 방식으로 개발 진행

## 라이센스

이 프로젝트는 MIT License를 따릅니다.

Copyright (c) 2026 Zaemin Kim

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

내가 지금 가장 불편한 게 뭘까?  
니치 타겟 집중
