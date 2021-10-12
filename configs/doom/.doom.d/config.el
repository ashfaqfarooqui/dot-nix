;; -*- lexical-binding: t; -*-

(setq user-full-name "Ashfaq Farooqui")
     (setq user-mail-address "ashfaq@ashfaqfarooqui.me")

(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil) ; default is 7200 (2h)

(defadvice! doom-modeline--reformat-roam (orig-fun)
  :around #'doom-modeline-buffer-file-name
  (message "Reformat?")
  (message (buffer-file-name))
  (if (s-contains-p org-roam-directory (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "🢔(\\1-\\2-\\3) "
       (funcall orig-fun))
    (funcall orig-fun)))

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string ".*/[0-9]*-?" "🢔 " buffer-file-name)
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; (after! org
;;   (use-package org-pretty-tags
;;   :config
;;    (setq org-pretty-tags-surrogate-strings
;;          `(("uni"        . ,(all-the-icons-faicon   "graduation-cap" :face 'all-the-icons-purple  :v-adjust 0.01))
;;            ("ucc"        . ,(all-the-icons-material "computer"       :face 'all-the-icons-silver  :v-adjust 0.01))
;;            ("assignment" . ,(all-the-icons-material "library_books"  :face 'all-the-icons-orange  :v-adjust 0.01))
;;            ("test"       . ,(all-the-icons-material "timer"          :face 'all-the-icons-red     :v-adjust 0.01))
;;            ("lecture"    . ,(all-the-icons-fileicon "keynote"        :face 'all-the-icons-orange  :v-adjust 0.01))
;;            ("email"      . ,(all-the-icons-faicon   "envelope"       :face 'all-the-icons-blue    :v-adjust 0.01))
;;            ("read"       . ,(all-the-icons-octicon  "book"           :face 'all-the-icons-lblue   :v-adjust 0.01))
;;            ("article"    . ,(all-the-icons-octicon  "file-text"      :face 'all-the-icons-yellow  :v-adjust 0.01))
;;            ("web"        . ,(all-the-icons-faicon   "globe"          :face 'all-the-icons-green   :v-adjust 0.01))
;;            ("info"       . ,(all-the-icons-faicon   "info-circle"    :face 'all-the-icons-blue    :v-adjust 0.01))
;;            ("issue"      . ,(all-the-icons-faicon   "bug"            :face 'all-the-icons-red     :v-adjust 0.01))
;;            ("someday"    . ,(all-the-icons-faicon   "calendar-o"     :face 'all-the-icons-cyan    :v-adjust 0.01))
;;            ("idea"       . ,(all-the-icons-octicon  "light-bulb"     :face 'all-the-icons-yellow  :v-adjust 0.01))
;;            ("emacs"      . ,(all-the-icons-fileicon "emacs"          :face 'all-the-icons-lpurple :v-adjust 0.01))))
;;    (org-pretty-tags-global-mode)))

(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        ;; org-superstar-headline-bullets-list '("Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")
        org-superstar-prettify-item-bullets t ))
(after! org
  (setq org-ellipsis " ▾ "
        org-priority-highest ?A
        org-priority-lowest ?E
        org-priority-faces
        '((?A . 'all-the-icons-red)
          (?B . 'all-the-icons-orange)
          (?C . 'all-the-icons-yellow)
          (?D . 'all-the-icons-green)
          (?E . 'all-the-icons-blue))))

(after! org
  (appendq! +ligatures-extra-symbols
            `(:checkbox      "☐"
              :pending       "◼"
              :checkedbox    "☑"
              :list_property "∷"
              :results       "🠶"
              :property      "☸"
              :properties    "⚙"
              :end           "∎"
              :options       "⌥"
              :title         "𝙏"
              :subtitle      "𝙩"
              :author        "𝘼"
              :date          "𝘿"
              :latex_header  "⇥"
              :latex_class   "🄲"
              :beamer_header "↠"
              :begin_quote   "❮"
              :end_quote     "❯"
              :begin_export  "⯮"
              :end_export    "⯬"
              :priority_a   ,(propertize "⚑" 'face 'all-the-icons-red)
              :priority_b   ,(propertize "⬆" 'face 'all-the-icons-orange)
              :priority_c   ,(propertize "■" 'face 'all-the-icons-yellow)
              :priority_d   ,(propertize "⬇" 'face 'all-the-icons-green)
              :priority_e   ,(propertize "❓" 'face 'all-the-icons-blue)
              :em_dash       "—"))
  (set-ligatures! 'org-mode
    :merge t
    :checkbox      "[ ]"
    :pending       "[-]"
    :checkedbox    "[X]"
    :list_property "::"
    :results       "#+results:"
    :property      "#+property:"
    :property      ":PROPERTIES:"
    :end           ":END:"
    :options       "#+options:"
    :title         "#+title:"
    :subtitle      "#+subtitle:"
    :author        "#+author:"
    :date          "#+date:"
    :latex_class   "#+latex_class:"
    :latex_header  "#+latex_header:"
    :beamer_header "#+beamer_header:"
    :begin_quote   "#+begin_quote"
    :end_quote     "#+end_quote"
    :begin_export  "#+begin_export"
    :end_export    "#+end_export"
    :priority_a    "[#A]"
    :priority_b    "[#B]"
    :priority_c    "[#C]"
    :priority_d    "[#D]"
    :priority_e    "[#E]"
    :em_dash       "---"))
(plist-put +ligatures-extra-symbols :name "⁍") ; or › could be good?

(add-hook 'org-mode-hook 'org-fragtog-mode)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 35)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 25)
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))

                                        ;(setq doom-font (font-spec :family "Overpass" :size 30)
                                        ;  doom-big-font (font-spec :family "fira code retina" :size 50)
                                        ;doom-variable-pitch-font (font-spec :family "Overpass" :size 33))
(after! doom-theme
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))



                                        ;(setq doom-font (font-spec :family "mononoki Nerd Font" :size 12 :weight 'semi-light)
                                        ;      doom-variable-pitch-font (font-spec :family "mononoki Nerd Font") ; inherits `doom-font''s :size
                                        ;      doom-big-font (font-spec :family "mononoki Nerd Font" :size 19))




                                        ;(setq doom-font (font-spec :family "mononoki Nerd Font" :size 12 :weight 'semi-light)
                                        ;      doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
                                        ;      doom-unicode-font (font-spec :family "mononoki Nerd Font" :size 12)
                                        ;      doom-big-font (font-spec :family "Fira Mono" :size 19))


                                        ;(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 30)
                                        ;      doom-big-font (font-spec :family "Mononoki Nerd Font" :size 36)
                                        ;      doom-variable-pitch-font (font-spec :family "iA Writer Quattro S" :size 24)
                                        ;)



                                        ;(setq doom-font (font-spec :family "iA Writer Quattro S" :size 24)
                                        ;      doom-big-font (font-spec :family "iA Writer Quattro S" :size 36)
                                        ;      doom-variable-pitch-font (font-spec :family "iA Writer Quattro S" :size 24)
                                        ;      doom-serif-font (font-spec :family "iA Writer Quattro S" :weight 'light))

(use-package! rainbow-mode
  :after rainbow-delimiter
:init (rainbow-mode))

(after! nyan-mode
     :init
    (nyan-mode))

(setq display-line-numbers-type 'relative)

(setq evil-move-cursor-back nil)

(define-key flyspell-mode-map (kbd "C-;") #'flyspell-correct-wrapper)

(after! super-save
(super-save-mode 1)
(setq super-save-exclude '(".gpg"))
(setq super-save-auto-save-when-idle t)
)

(add-hook! org-mode :append
           #'visual-line-mode)

(add-hook! text-mode :append
           #'visual-line-mode)

(add-hook! latex-mode :append
           #'visual-line-mode)

(use-package! visual-fill-column
  :config
  (add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
  (advice-add 'text-scale-adjust :after
              #'visual-fill-column-adjust)
  (setq visual-fill-column-width 100)
  (setq-default fill-column 100)
  (setq visual-fill-column-center-text t)
  )

(after! smartparens
  :config
  (map! :map smartparens-mode-map
        "C-M-f" #'sp-forward-sexp
        "C-M-b" #'sp-backward-sexp
        "C-M-u" #'sp-backward-up-sexp
        "C-M-d" #'sp-down-sexp
        "C-M-p" #'sp-backward-down-sexp
        "C-M-n" #'sp-up-sexp
        "C-M-s" #'sp-splice-sexp
        "C-)" #'sp-forward-slurp-sexp
        "C-}" #'sp-forward-barf-sexp
        "C-(" #'sp-backward-slurp-sexp
        "C-M-)" #'sp-backward-slurp-sexp
        "C-M-)" #'sp-backward-barf-sexp))

(after! org
  (defun dcaps-to-scaps ()
    "Convert word in DOuble CApitals to Single Capitals."
    (interactive)
    (and (= ?w (char-syntax (char-before)))
         (save-excursion
           (let ((end (point)))
             (and (if (called-interactively-p)
                      (skip-syntax-backward "w")
                    (= -3 (skip-syntax-backward "w")))
                  (let (case-fold-search)
                    (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
                  (capitalize-region (point) end))))))
  (add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)

  (define-minor-mode dubcaps-mode
    "Toggle `dubcaps-mode'.  Converts words in DOuble CApitals to
Single Capitals as you type."
    :init-value nil
    :lighter (" DC")
    (if dubcaps-mode
        (add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)
      (remove-hook 'post-self-insert-hook #'dcaps-to-scaps 'local)))


  (add-hook 'text-mode-hook #'dubcaps-mode)
  (add-hook 'org-mode-hook #'dubcaps-mode))

(use-package! info-colors
  :defer t
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

                                        ;(add-hook 'Info-mode-hook #'mixed-pitch-mode)

(after! text-mode
  (add-hook! 'text-mode-hook
             ;; Apply ANSI color codes
             (with-silent-modifications
               (ansi-color-apply-on-region (point-min) (point-max)))))

(setq ispell-dictionary "en")

(defun greedily-do-daemon-setup ()
  (require 'org)
  (when (require 'mu4e nil t)
    (setq mu4e-confirm-quit t)
    (setq +mu4e-lock-greedy t)
    (setq +mu4e-lock-relaxed t)
    (+mu4e-lock-add-watcher)
    (when (+mu4e-lock-available t)
      (mu4e~start)))
  (when (require 'elfeed nil t)
    (run-at-time nil (* 8 60 60) #'elfeed-update)))

(when (daemonp)
  (add-hook 'emacs-startup-hook #'greedily-do-daemon-setup)
(add-hook! 'server-after-make-frame-hook (switch-to-buffer +doom-dashboard-name))
                        )

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq initial-major-mode 'org-mode)
(setq hungry-delete-mode t)
(show-smartparens-mode)
(global-hungry-delete-mode)
(nyan-mode)

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(after! org
(add-to-list 'org-modules 'org-habit t)
; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

(require 'org-habit)
(setq org-habit-following-days 7)
(setq org-habit-preceding-days 35)
(setq org-habit-show-habits t)
)

(after! org
(setq org-directory "~/Nextcloud/Docs")

  (defun org-file-path (filename)
    "Return the absolute address of an org file, given its relative name."
    (concat (file-name-as-directory org-directory) filename))

  (setq org-inbox-orgzly-file
        (concat (org-file-path "inbox-orgzly.org")))
  (setq org-inbox-file (org-file-path "inbox.org"))
(setq org-basb-main-file (concat (org-file-path "Roam/index.org")))
)

(defun my/open-main-file ()
  (interactive)
(org-open-file org-basb-main-file)
                        )

(after! org
  (setq org-pretty-entities          t ; UTF8 all the things!
        org-support-shift-select     t ; holding shift and moving point should select things
        org-M-RET-may-split-line     nil ; M-RET may never split a line
        org-enforce-todo-dependencies t ; can't finish parent before children
        org-enforce-todo-checkbox-dependencies t ; can't finish parent before children
        org-hide-emphasis-markers nil ; make words italic or bold, hide / and *
        org-fold-catch-invisible-edits 'smart
                                        ;org-catch-invisible-edits 'error ; don't let me edit things I can't see
        org-startup-indented t) ; start with indentation setup
  (setq org-startup-with-inline-images t) ; show inline images
  (setq org-log-done t)
  (setq org-goto-interface (quote outline-path-completion))

  (setq org-special-ctrl-a/e t))

(after! org
  (add-to-list 'org-todo-keywords '(sequence "APT"))
  (add-to-list 'org-todo-keyword-faces '(("APT" . +org-todo-active)))

  )

; Tags with fast selection keys
(after! org

;  (setq org-tag-alist (quote ((:startgroup)
;                            ("@errand" . ?e)
;                            ("@office" . ?o)
;                            ("@home" . ?H)
;                            (:endgroup)
;                      ("Challenge" . ?1)
;                      ("Average" . ?2)
;                      ("Easy" . ?3)
;                            ("crypt" . ?E)
;                            ("NOTE" . ?n)
;)))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)
)

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(after! org   (setq org-capture-templates
            (quote (

                    ("p" "Protocol" entry (file+headline org-inbox-file "Links")
                     "* %^{Title}\nCaptured On: %U\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                    ("L" "Protocol Link" entry (file+headline org-inbox-file "Links")
                     "* %? [[%:link][%:description]] \nCaptured On: %U")

                    ("P" "Project" entry (file+headline org-basb-main-file "Projects")
                     (file "~/.doom.d/templates/newProjecttemplate.org") :empty-lines 1)

                    ("s" "Someday" entry (file+headline (concat (org-file-path "BASB/somedaymaybe.org" "Someday")))
                     "* %?\n")
                    ("m" "Maybe" entry (file+headline (concat (org-file-path "BASB/somedaymaybe.org" "Maybe")))
                     "* %?\n")


                    ("n" "Notes"
                     entry
                     (file+headline org-inbox-file "Notes")
                     "* %u %? :NOTE:\n")

                    ("t" "Task"
                     entry
                     (file+headline org-inbox-file "Tasks")
                     "* TODO %?\n")

                     ("h" "health log")
                    ("hr" "Running" entry (file+headline  "~/Orgs/BASB/Areas/Health/log.org" "Running")
                     (file "~/.doom.d/templates/running.org") :empty-lines 1)

                    ("hs" "Sleep" entry (file+headline  "~/Orgs/BASB/Areas/Health/log.org" "Sleep")
                     (file "~/.doom.d/templates/sleep.org") :empty-lines 1)


                    ("e" "Email" entry (file+headline org-inbox-file "Mail")
                     "* TODO %? email |- %:from: %:subject :EMAIL:\n:PROPERTIES:\n:CREATED: %U\n:EMAIL-SOURCE: %l\n:END:\n%U\n" )



                    ("H" "Habit" entry (file org-inbox-file)
                     "* TODO %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:END:\n")


                    ("c" "cooking")
                    ("cr" "Cookbook" entry (file (concat (org-file-path  "BASB/Reference/Cookbook/cookbook.org")))
                     "%(org-chef-get-recipe-from-url)"
                     :empty-lines 1)

                    ("cm" "Manual Cookbook" entry (file (concat (org-file-path "BASB/Reference/Cookbook/cookbook.org")))
                     "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")

              )


                    ))

)

(after! org
(setq org-crypt-disable-auto-save nil)
(require 'org-crypt)
; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
; GPG key to use for encryption
(setq org-crypt-key "51DE2D88")
)

(after! org-roam
  (setq org-roam-directory "~/Nextcloud/Docs/Roam/")
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+Date: %t")
           :unnarrowed t)
          ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
           :unnarrowed t)
          ("c" "Cooking" plain "%?"
           :if-new (file+head "$Areas/Cooking/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+Date: %t")
           :unnarrowed t)
          ("p" "People" plain "%?"
           :if-new (file+head "References/People/${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("i" "Religion")
          ("in" "note" plain "%?"
           :if-new (file+head "Areas/Religion/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#title: ${title}\n")
           :unnarrowed t)

          ("ik" "Kuthbah" plain "%?"
           :if-new (file+head) "Areas/Religion/Khutba/%<%Y%m%d%H%M%S>-${slug}.org" "#title: ${title}\n#+Date: %(org-read-date nil nil nil)")
          )

        )


  )

;; Taking things from system crafters
(after! org-roam
  (require 'org-roam-dailies) ;; Ensure the keymap is available

  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (push arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))

  (defun my/org-roam-filter-by-tag (tag-name)
    (lambda (node)
      (member tag-name (org-roam-node-tags node))))

  (defun my/org-roam-list-notes-by-tag (tag-name)
    (mapcar #'org-roam-node-file
            (seq-filter
             (my/org-roam-filter-by-tag tag-name)
             (org-roam-node-list))))
 (defun my/org-roam-refresh-agenda-list ()
    (interactive)


    (setq org-agenda-files (cl-remove-duplicates (append (my/org-roam-list-notes-by-tag "Project")
                                                         (my/org-roam-list-notes-by-tag "Area")
                                                         (my/org-roam-list-notes-by-tag "REFILE"))))

    )

  ;; Build the agenda list the first time for the session
  (my/org-roam-refresh-agenda-list)

  (defun my/org-roam-project-finalize-hook ()
    "Adds the captured project file to `org-agenda-files' if the
capture was not aborted."
    ;; Remove the hook since it was added temporarily
    (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

    ;; Add project file to the agenda list if the capture was confirmed
    (unless org-note-abort
      (with-current-buffer (org-capture-get :buffer)
        (add-to-list 'org-agenda-files (buffer-file-name)))))

  (defun my/org-roam-find-area ()
    (interactive)
    ;; Add the project file to the agenda after capture is finished
    (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

    ;; Select a project file to open, creating it if necessary
    (org-roam-node-find
     nil
     nil
     (my/org-roam-filter-by-tag "Area")
     :templates
     '(("a" "area" plain "\n"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Area")
        :unnarrowed t))))


  (defun my/org-roam-find-project ()
    (interactive)
    ;; Add the project file to the agenda after capture is finished
    (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

    ;; Select a project file to open, creating it if necessary
    (org-roam-node-find
     nil
     nil
     (my/org-roam-filter-by-tag "Project")
     :templates
     '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
        :unnarrowed t))))

  (defun my/org-roam-capture-inbox ()
    (interactive)
    (org-roam-capture- :node (org-roam-node-create)
                       :templates '(("i" "inbox" plain "* %?"
                                     :if-new (file+head "Inbox.org" "#+title: Inbox\n#+filetags: Inbox")))))

  (defun my/org-roam-capture-task ()
    (interactive)
    ;; Add the project file to the agenda after capture is finished
    (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

    ;; Capture the new task, creating the project file if necessary
    (org-roam-capture- :node (org-roam-node-read
                              nil
                              (my/org-roam-filter-by-tag "Project"))
                       :templates '(("p" "project" plain "** TODO %?"
                                     :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                                                            "#+title: ${title}\n#+category: ${title}\n#+filetags: Project"
                                                            ("Tasks"))))))

  (defun my/org-roam-copy-todo-to-today ()
    (interactive)
    (let ((org-refile-keep t) ;; Set this to nil to delete the original!
          (org-roam-dailies-capture-templates
           '(("t" "tasks" entry "%?"
              :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
          (org-after-refile-insert-hook #'save-buffer)
          today-file
          pos)
      (save-window-excursion
        (org-roam-dailies--capture (current-time) t)
        (setq today-file (buffer-file-name))
        (setq pos (point)))

      ;; Only refile if the target file is different than the current file
      (unless (equal (file-truename today-file)
                     (file-truename (buffer-file-name)))
        (org-refile nil nil (list "Tasks" today-file nil pos)))))

  (add-to-list 'org-after-todo-state-change-hook
               (lambda ()
                 (when (equal org-state "DONE")
                   (my/org-roam-copy-todo-to-today))))

  )
(map! :leader
      (:prefix-map ("r" . "personal")
       "a" #'my/org-roam-find-area
       "p" #'my/org-roam-find-project
       "t" #'my/org-roam-capture-task
       "b" #'my/org-roam-capture-inbox
       ))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;    :hook
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq deft-directory org-roam-directory)

;;;###autoload


(after! org
(defmacro unpackaged/def-org-maybe-surround (&rest keys)
  "Define and bind interactive commands for each of KEYS that surround the region or insert text.
Commands are bound in `org-mode-map' to each of KEYS.  If the
region is active, commands surround it with the key character,
otherwise call `org-self-insert-command'."
  `(progn
     ,@(cl-loop for key in keys
                for name = (intern (concat "unpackaged/org-maybe-surround-" key))
                for docstring = (format "If region is active, surround it with \"%s\", otherwise call `org-self-insert-command'." key)
                collect `(defun ,name ()
                           ,docstring
                           (interactive)
                           (if (region-active-p)
                               (let ((beg (region-beginning))
                                     (end (region-end)))
                                 (save-excursion
                                   (goto-char end)
                                   (insert ,key)
                                   (goto-char beg)
                                   (insert ,key)))
                             (call-interactively #'org-self-insert-command)))
                collect `(define-key org-mode-map (kbd ,key) #',name))))

(unpackaged/def-org-maybe-surround "~" "=" "*" "/" "+"))

(after! org (setq org-export-headline-levels 5)) ; I like nesting

(after! org
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(after! org
  (defun narrow-or-widen-dwim (p)
    "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p)) (widen))
          ((region-active-p)
           (narrow-to-region (region-beginning)
                             (region-end)))
          ((derived-mode-p 'org-mode)
           ;; `org-edit-src-code' is not a real narrowing
           ;; command. Remove this first conditional if
           ;; you don't want it.
           (cond ((ignore-errors (org-edit-src-code) t)
                  (delete-other-windows))
                 ((ignore-errors (org-narrow-to-block) t))
                 (t (org-narrow-to-subtree))))
          ((derived-mode-p 'latex-mode)
           (LaTeX-narrow-to-environment))
          (t (narrow-to-defun))))

  )

(after! treemacs
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))

        (setq treemacs-file-ignore-extensions
      '(;; LaTeX
        "aux"
        "ptc"
        "fdb_latexmk"
        "fls"
        "synctex.gz"
        "toc"
        ;; LaTeX - glossary
        "glg"
        "glo"
        "gls"
        "glsdefs"
        "ist"
        "acn"
        "acr"
        "alg"
        ;; LaTeX - pgfplots
        "mw"
        ;; LaTeX - pdfx
        "pdfa.xmpi"
        ))
(setq treemacs-file-ignore-globs
      '(;; LaTeX
        "*/_minted-*"
        ;; AucTeX
        "*/.auctex-auto"
        "*/_region_.log"
        "*/_region_.tex"))

;;; :tools magit

(after! magit

 (setq magit-repository-directories '(("~/Code" . 2) ("~/Papers" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit, it's jarring
      magit-inhibit-save-previous-winconf t
      transient-values '((magit-commit "--gpg-sign=7A804BCB51DE2D88")
                         (magit-rebase "--autosquash" "--gpg-sign=7A804BCB51DE2D88")
                         (magit-pull "--rebase" "--gpg-sign=7A804BCB51DE2D88")))

 (setq magit-repolist-columns
      '(("Name"    25 magit-repolist-column-ident                  ())
        ("Version" 25 magit-repolist-column-version                ())
        ("D"        1 magit-repolist-column-dirty                  ())
        ("Branch"  10 magit-repolist-column-branch                () )
        ("L<U"      3 magit-repolist-column-unpulled-from-upstream ((:right-align t)))
        ("L>U"      3 magit-repolist-column-unpushed-to-upstream   ((:right-align t)))
        ("Path"    99 magit-repolist-column-path                   ())))


)

(after! elfeed

  (elfeed-org)

  (setq elfeed-search-filter "@4-week-ago +unread"
                                        ;                elfeed-search-print-entry-function '+rss/elfeed-search-print-entry
        elfeed-search-title-min-width 80
        )
  )



(after! elfeed-org
  :config
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update)
  (setq elfeed-db-directory "~/Documents/elfeed")
  (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org")))

(map! :map elfeed-search-mode-map
      :after elfeed-search
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :n "q" #'+rss/quit
      :n "e" #'elfeed-update
      :n "r" #'elfeed-search-untag-all-unread
      :n "u" #'elfeed-search-tag-all-unread
      :n "s" #'elfeed-search-live-filter
      :n "RET" #'elfeed-search-show-entry
      :n "p" #'elfeed-show-pdf
      :n "+" #'elfeed-search-tag-all
      :n "-" #'elfeed-search-untag-all
      :n "S" #'elfeed-search-set-filter
      :n "b" #'elfeed-search-browse-url
      :n "y" #'elfeed-search-yank
      :n "e" #'prot/elfeed-show-eww
        )

(map! :map elfeed-show-mode-map
      :after elfeed-show
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :nm "q" #'+rss/delete-pane
      :nm "o" #'ace-link-elfeed
      :nm "RET" #'org-ref-elfeed-add
      :nm "n" #'elfeed-show-next
      :nm "N" #'elfeed-show-prev
      :nm "p" #'elfeed-show-pdf
      :nm "+" #'elfeed-show-tag
      :nm "-" #'elfeed-show-untag
      :nm "s" #'elfeed-show-new-live-search
      :nm "y" #'elfeed-show-yank
        )

(after! org (defun go-to-projects ()
  (interactive)
  (find-file org-basb-main-file)
  (widen)
  (beginning-of-buffer)
  (re-search-forward "* Projects")
  (beginning-of-line))

(defun project-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?p)
  (org-columns))

(defun project-deadline-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?d)
  (org-columns))
)

(after! org (defun my-org-agenda-list-stuck-projects ()
  (interactive)
  (go-to-projects)
  (org-agenda nil "#" 'subtree))
)

(after! org  (defun go-to-areas ()
    (interactive)
    (find-file org-basb-main-file)
    (widen)
    (beginning-of-buffer)
    (re-search-forward "* Areas")
    (beginning-of-line))

(defun areas-overview ()
    (interactive)
    (go-to-areas)
    (org-narrow-to-subtree)
    (org-columns))
)

(after! org (defun my-new-daily-review ()
  (interactive)
  (let ((org-capture-templates '(("d" "Review: Daily Review" entry (file+olp+datetree "/tmp/reviews.org")
                                  (file "~/.doom.d/templates/dailyreviewtemplate.org")))))
    (progn
      (org-capture nil "d")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-weekly-review ()
  (interactive)
  (let ((org-capture-templates '(("w" "Review: Weekly Review" entry (file+olp+datetree "/tmp/reviews.org")
                                  (file "~/.doom.d/templates/weeklyreviewtemplate.org")))))
    (progn
      (org-capture nil "w")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-monthly-review ()
  (interactive)
  (let ((org-capture-templates '(("m" "Review: Monthly Review" entry (file+olp+datetree "/tmp/reviews.org")
                                  (file "~/.doom.d/templates/monthlyreviewtemplate.org")))))
    (progn
      (org-capture nil "m")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))


;(bind-keys :prefix-map review-map
;           :prefix "C-z d"
;           ("d" . my-new-daily-review)
;           ("w" . my-new-weekly-review)
;           ("m" . my-new-monthly-review))

(f-touch "/tmp/reviews.org")

)

(use-package! lexic
  :defer t
  :commands lexic-search lexic-list-dictionary
  )

(after! mu4e


  (setq mu4e-headers-fields
        '((:flags . 6)
          (:account-stripe . 2)
          (:from-or-to . 25)
          (:folder . 10)
          (:recipnum . 2)
          (:subject . 80)
          (:human-date . 8))
        +mu4e-min-header-frame-width 142
        mu4e-headers-date-format "%d/%m/%y"
        mu4e-headers-time-format "⧖ %H:%M"
        mu4e-headers-results-limit 1000
        mu4e-index-cleanup t)

  (add-to-list 'mu4e-bookmarks
               '(:name "Yesterday's messages" :query "date:2d..1d" :key ?y) t)

  (defvar +mu4e-header--folder-colors nil)
  (appendq! mu4e-header-info-custom
            '((:folder .
               (:name "Folder" :shortname "Folder" :help "Lowest level folder" :function
                (lambda (msg)
                  (+mu4e-colorize-str
                   (replace-regexp-in-string "\\`.*/" "" (mu4e-message-field msg :maildir))
                   '+mu4e-header--folder-colors))))))


  ;; spell check
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
  (setq mu4e-update-interval 600)



                                        ;(setq mu4e-compose-signature-auto-include t)




  (setq mu4e-enable-mode-line t)

  (set-email-account! "ashfaqfarooqui.me"
                      '(
                        ( user-mail-address      . "ashfaq@ashfaqfarooqui.me"  )
                        ( user-full-name         . "Ashfaq Farooqui" )
                        (mu4e-sent-folder       . "/ashfaqfarooqui.me/Sent Mail")
                        (mu4e-drafts-folder     . "/ashfaqfarooqui.me/Drafts")
                        (mu4e-trash-folder      . "/ashfaqfarooqui.me/Trash")
                        (mu4e-refile-folder     . "/ashfaqfarooqui.me/All Mail")
                        (smtpmail-smtp-user     . "ashfaq.farooqui@mailbox.org")
                        ;;    (user-mail-address      . "ashfaq@ashfaqfarooqui.me")    ;; only needed for mu < 1.4
                        (mu4e-attachment-dir . "~/Documents/MailAttachments/Personal")
                        (smtpmail-smtp-server . "smtp.mailbox.org")
                        (smtpmail-stream-type . ssl )
                        (smtpmail-smtp-service . 465)
                        (mu4e-compose-signature . "---\nAshfaq Farooqui"))
                      t)
  (set-email-account! "ri.se"
                      '(
                        ( user-mail-address      . "ashfaq.farooqui@ri.se"  )
                        ( user-full-name         . "Ashfaq Farooqui" )
                        (mu4e-sent-folder       . "/ri.se/Sent Mail")
                        (mu4e-drafts-folder     . "/ri.se/Drafts")
                        (mu4e-trash-folder      . "/ri.se/Trash")
                        (mu4e-refile-folder     . "/ri.se/All Mail")
                        (smtpmail-smtp-user     . "ashfaq.farooqui@ri.se")
                        ;;    (user-mail-address      . "ashfaq@ashfaqfarooqui.me")    ;; only needed for mu < 1.4
                        (mu4e-attachment-dir . "~/Documents/MailAttachments/RISE")
                        (mu4e-compose-signature . "//Ashfaq Farooqui")
                        ( smtpmail-smtp-server   . "localhost" )
                        (smtpmail-stream-type . nil )
                        ( smtpmail-smtp-service . 1025)
                        )
                      t)

                                        ;(setq smtpmail-debug-verb t)


                                        ;(setq mu4e-compose-signature message-signature)


  )

;;;Taking the below from [[http://mbork.pl/2016-02-06_An_attachment_reminder_in_mu4e]]
(after! mu4e
    (defun mbork/message-attachment-present-p ()
      "Return t if an attachment is found in the current message."
      (save-excursion
        (save-restriction
          (widen)
          (goto-char (point-min))
          (when (search-forward "<#part" nil t) t))))

    (defcustom mbork/message-attachment-intent-re
      (regexp-opt '("I attach"
                    "I have attached"
                    "I've attached"
                    "I have included"
                    "I've included"
                    "see the attached"
                    "see the attachment"
                    "attached file"))
      "A regex which - if found in the message, and if there is no
    attachment - should launch the no-attachment warning.")

    (defcustom mbork/message-attachment-reminder
      "Are you sure you want to send this message without any attachment? "
      "The default question asked when trying to send a message
    containing `mbork/message-attachment-intent-re' without an
    actual attachment.")

    (defun mbork/message-warn-if-no-attachments ()
      "Ask the user if s?he wants to send the message even though
    there are no attachments."
      (when (and (save-excursion
                   (save-restriction
                     (widen)
                     (goto-char (point-min))
                     (re-search-forward mbork/message-attachment-intent-re nil t)))
                 (not (mbork/message-attachment-present-p)))
        (unless (y-or-n-p mbork/message-attachment-reminder)
          (keyboard-quit))))

    (add-hook 'message-send-hook #'mbork/message-warn-if-no-attachments)


)

(after! org-msg
                                        ;use-package! org-msg
                                        ;  :after mu4e
                                        ;:config
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil"
	org-msg-startup "hidestars indent inlineimages"
	org-msg-greeting-fmt "\nHi *%s*,\n\n"
	org-msg-greeting-name-limit 3
	org-msg-signature "



 #+begin_signature
 //Ashfaq
 #+end_signature")
  )

(after! lsp-mode
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))


                            (require 'dap-cpptools)
(setq dap-auto-configure-features '(sessions locals controls tooltip))

)

(after! lsp-mode
(add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                  :major-modes '(nix-mode)
                  :server-id 'nix))
)
