'use strict'

###*
 # @ngdoc function
 # @name frontendAppApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the frontendAppApp
###
angular.module('frontendAppApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
