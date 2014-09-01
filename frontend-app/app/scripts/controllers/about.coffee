'use strict'

###*
 # @ngdoc function
 # @name frontendAppApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the frontendAppApp
###
angular.module('frontendAppApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
