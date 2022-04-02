defcomp comp-container (reel docs)
  let
      store $ :store reel
      states $ :states store
      cursor $ or (:cursor states) ([])
      state $ or (:data states)
        {}
          :selected $ []
          :history $ []
      selected $ :selected state
      history $ :history state
      quick-modal $ use-modal (>> states :quick)
        {} (:title "|Quick jump")
          :style $ {} (:max-width "\"40vw") (:height "\"90vh") (:max-height "\"90vh") (:margin-right 0)
          :render $ fn (on-close)
            div
              {} $ :style
                {} $ :padding "\"0 16px"
              comp-nav-tree docs ([])
                fn (path d!)
                  d! cursor $ next-path state path
    div
      {} (:class-name "\"calcit-tile")
        :style $ merge ui/fullscreen ui/global ui/row
      div
        {} $ :style
          {} (:padding "\"0 8px") (:width "\"20%") (:min-width 266) (:background-color :white)
            :border-right $ str "\"1px solid " (hsl 0 0 94)
        div
          {}
            :style $ {} (:position :absolute) (:right 8) (:top 4)
            :on-click $ fn (e d!) (.show quick-modal d!)
          <> "\"Quick Jump" $ {} (:cursor :pointer) (:font-family ui/font-fancy)
        div
          {} $ :style
            {} $ :margin-top 12
          <> "\"Pages" $ {} (:font-family ui/font-fancy)
        comp-parent-menu selected docs $ fn (path d!)
          d! cursor $ next-path state path
        let
            parent-path $ or (butlast selected) ([])
            entries $ find-entries docs parent-path
          comp-page-entries (last selected) parent-path entries $ fn (xs d!)
            d! cursor $ next-path state xs
        div
          {} $ :style
            {} $ :margin-top 20
          <> "\"Histories" $ {} (:font-family ui/font-fancy)
          comp-history-menu history $ fn (path d!)
            d! cursor $ next-path state path
      let
          target $ find-target docs (:selected state)
        div
          {} $ :style ui/expand
          let
              children $ or (:children target) ([])
            if (empty? children) nil $ div
              {} $ :style
                {} $ :padding "\"16px"
              div ({})
                <> "\"Children pages" $ {} (:font-family ui/font-fancy)
              comp-page-entries nil (:selected state) children $ fn (xs d!)
                d! cursor $ next-path state xs
          comp-doc-page target
      .render quick-modal
      when dev? $ comp-reel (>> states :reel) reel ({})
