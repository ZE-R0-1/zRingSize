# zRingSize

zRingSize는 iOS 기기를 사용하여 반지 크기와 손가락 크기를 측정할 수 있는 앱입니다.

## 주요 기능

1. **반지 크기 측정**: 반지를 휴대폰 화면에 올려놓고 정확한 호수를 확인할 수 있습니다.
2. **손가락 크기 측정**: 손가락을 휴대폰 화면에 올려놓고 해당하는 반지 호수를 확인할 수 있습니다.
3. **측정 기록**: 과거의 측정 결과를 저장하고 확인할 수 있습니다.
4. **사이즈 차트**: 다양한 국가 및 브랜드의 반지 사이즈 차트를 제공합니다.

## 프로젝트 구조

```
zRingSize/
├── App/
│   └── zRingSizeApp.swift
├── Views/
│   ├── Main/
│   │   ├── HomeView.swift
│   │   └── MeasurementGridView.swift
│   ├── Measurement/
│   │   ├── RingView.swift
│   │   ├── FingerView.swift
│   │   └── MeasurementGuideView.swift
│   ├── History/
│   │   ├── HistoryView.swift
│   │   ├── MeasurementRowView.swift
│   │   └── MeasurementDetailView.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   ├── SettingsItemView.swift
│   │   ├── SizeChartView.swift
│   │   └── MailView.swift
│   └── Common/
│       └── WebView.swift
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── RingViewModel.swift
│   ├── FingerViewModel.swift
│   ├── HistoryViewModel.swift
│   └── SettingsViewModel.swift
├── Models/
│   ├── SizeRecord.swift
│   └── SizeModel.swift
├── Services/
│   └── MeasurementService.swift
└── Utilities/
    ├── Constants.swift
    ├── DeviceInfo.swift
    ├── Color+Extensions.swift
    └── Date+Extensions.swift
```

## 기술 스택

- Swift
- SwiftUI
- MVVM 아키텍처
