;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(setq exec-shell-from-path nil)

                                        ;(package! mmm-mode)
(package! multi-web-mode)
                                        ;(package! web-mode)
(package! wgrep)
(package! swiper)
(package! ag)
(package! wgrep-ag)
(package! exec-path-from-shell)
(package! play-sound :recipe (:fetcher github :repo "leoliu/play-sound-osx"))
;; PHPActor has an issue installing with the default, cause the JSON files
;; are missing
(when (featurep! :lang php)
  (package! zephir-mode :recipe
    (:fetcher "github" :repo "sergeyklay/zephir-mode")))
;(package! php-boris :disable t)
;(package! ac-php-core)
;(package! company-php :disable t)
(when (featurep! :lang php)
  (package! composer))
(when (featurep! :lang php)
  (package! php-runtime))
(when (and (featurep! :completion company) (featurep! :lang php))
   (package! ac-php-core :recipe
     (:fetcher github :repo "xcwen/ac-php")))
(when (and (featurep! :feature lookup) (featurep! :lang php))
  (package! php-eldoc))
