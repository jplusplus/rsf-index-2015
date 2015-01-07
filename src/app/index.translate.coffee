angular.module "rsfIndex2015"
	.config ($translateProvider) ->
		$translateProvider.useStaticFilesLoader
			prefix: 'assets/locale/'
			suffix: '.json'
    $translateProvider.preferredLanguage('en');
		$translateProvider.fallbackLanguage('en');
