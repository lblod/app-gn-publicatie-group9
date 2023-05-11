(define-resource behandeling-van-agendapunt ()
  :class (s-prefix "besluit:BehandelingVanAgendapunt")
  :properties `((:openbaar :boolean ,(s-prefix "besluit:openbaar"))
                (:gevolg :language-string ,(s-prefix "besluit:gevolg"))
                (:afgeleid-uit :string ,(s-prefix "pav:derivedFrom"))
                (:position :int ,(s-prefix "schema:position")))
  :has-many `((besluit :via ,(s-prefix "prov:generated")
                       :as "besluiten")
              (mandataris :via ,(s-prefix "besluit:heeftAanwezige")
                          :as "aanwezigen")
              (stemming :via ,(s-prefix "besluit:heeftStemming")
                          :as "stemmingen"))
  :has-one `((behandeling-van-agendapunt :via ,(s-prefix "besluit:gebeurtNa")
                                         :as "vorige-behandeling-van-agendapunt")
             (agendapunt :via ,(s-prefix "dct:subject")
                              :as "onderwerp")
             (mandataris :via ,(s-prefix "besluit:heeftSecretaris")
                         :as "secretaris")
             (mandataris :via ,(s-prefix "besluit:heeftVoorzitter")
                         :as "voorzitter"))
  :resource-base (s-url "http://data.lblod.info/id/behandelingen-van-agendapunt")
  :features '(include-uri)
  :on-path "behandelingen-van-agendapunten")