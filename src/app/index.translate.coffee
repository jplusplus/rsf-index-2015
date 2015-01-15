angular.module "rsfIndex2015"
  .config ($translateProvider) ->
    $translateProvider
      .useStaticFilesLoader
        prefix: 'assets/locale/'
        suffix: '.json'
      .registerAvailableLanguageKeys ['en', 'fr', 'es'],
        'en_US': 'en'
        'en_UK': 'en'
        'fr_FR': 'fr'
        'fr_CA': 'fr'
        'fr_BE': 'fr'
        'es_ES': 'es'
      .preferredLanguage 'en'
      .fallbackLanguage 'en'
      .useMessageFormatInterpolation()
      .determinePreferredLanguage()
      .useCookieStorage()
