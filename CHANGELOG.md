## [Unreleased]

## [0.1.0] - 2025-01-24

- Initial release

## [0.2.0] - 2025-02-03

- Restructured gem and renamed some components
- Added new builders:
  - Faraday based: `RaiseError`, `Instrumentation`, `Json` (`Request` and `Response`), `Multipart`, `Persistent`
  - Utility: `Cached`, `IdQuery`, `Only` (`OnlyBoby` and `OnlyHeaders`)
- Added "Caching Services":
  - `WithRails` using `Rails.cache.fetch`
  - `WithRedis` not implemented
  - `WithMemory` using memoization. Intended for testing/local purposes
- Expanded `Options`

## [0.2.1] - 2025-02-04

- Added ruby 3.0 support
