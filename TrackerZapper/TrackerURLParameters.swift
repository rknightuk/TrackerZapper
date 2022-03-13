//
//  TrackerURLParameters.swift
//  TrackerZapper
//
//  Created by Arthur Lockman on 3/13/22.
//

import Foundation

class TrackerParameter {
    var website: String = ""
    var parameterPrefix: String

    init(parameterPrefix: String, website: String)
    {
        self.website = website
        self.parameterPrefix = parameterPrefix
    }

    init(parameterPrefix: String)
    {
        self.website = ""
        self.parameterPrefix = parameterPrefix
    }
}

// prefixes from various places including
// https://github.com/newhouse/url-tracking-stripper/blob/master/assets/js/trackers.js
let paramsToRemove = [
    TrackerParameter(parameterPrefix: "_bta_c"),
    TrackerParameter(parameterPrefix: "_bta_tid"),
    TrackerParameter(parameterPrefix: "_ga"),
    TrackerParameter(parameterPrefix: "_hsenc"),
    TrackerParameter(parameterPrefix: "_hsmi"),
    TrackerParameter(parameterPrefix: "_ke"),
    TrackerParameter(parameterPrefix: "_openstat"),
    TrackerParameter(parameterPrefix: "cid"),
    TrackerParameter(parameterPrefix: "dm_i"),
    TrackerParameter(parameterPrefix: "ef_id"),
    TrackerParameter(parameterPrefix: "epik"),
    TrackerParameter(parameterPrefix: "fbclid"),
    TrackerParameter(parameterPrefix: "gclid"),
    TrackerParameter(parameterPrefix: "gclsrc"),
    TrackerParameter(parameterPrefix: "gdffi"),
    TrackerParameter(parameterPrefix: "gdfms"),
    TrackerParameter(parameterPrefix: "gdftrk"),
    TrackerParameter(parameterPrefix: "hsa_"),
    TrackerParameter(parameterPrefix: "igshid"),
    TrackerParameter(parameterPrefix: "matomo_"),
    TrackerParameter(parameterPrefix: "mc_"),
    TrackerParameter(parameterPrefix: "mkwid"),
    TrackerParameter(parameterPrefix: "msclkid"),
    TrackerParameter(parameterPrefix: "mtm_"),
    TrackerParameter(parameterPrefix: "ns_"),
    TrackerParameter(parameterPrefix: "oly_anon_id"),
    TrackerParameter(parameterPrefix: "oly_enc_id"),
    TrackerParameter(parameterPrefix: "otc"),
    TrackerParameter(parameterPrefix: "pcrid"),
    TrackerParameter(parameterPrefix: "piwik_"),
    TrackerParameter(parameterPrefix: "pk_"),
    TrackerParameter(parameterPrefix: "rb_clickid"),
    TrackerParameter(parameterPrefix: "redirect_log_mongo_id"),
    TrackerParameter(parameterPrefix: "redirect_mongo_id"),
    TrackerParameter(parameterPrefix: "ref"),
    TrackerParameter(parameterPrefix: "s_kwcid"),
    TrackerParameter(parameterPrefix: "sb_referer_host"),
    TrackerParameter(parameterPrefix: "scrolla"),
    TrackerParameter(parameterPrefix: "soc_src"),
    TrackerParameter(parameterPrefix: "soc_trk"),
    TrackerParameter(parameterPrefix: "spm"),
    TrackerParameter(parameterPrefix: "sr_"),
    TrackerParameter(parameterPrefix: "srcid"),
    TrackerParameter(parameterPrefix: "stm_"),
    TrackerParameter(parameterPrefix: "trk_"),
    TrackerParameter(parameterPrefix: "utm_"),
    TrackerParameter(parameterPrefix: "vero_"),
    TrackerParameter(parameterPrefix: "t", website: "twitter"),
    TrackerParameter(parameterPrefix: "s", website: "twitter"),
    TrackerParameter(parameterPrefix: "si", website: "spotify"),
    TrackerParameter(parameterPrefix: "pd_", website: "amazon"),
    TrackerParameter(parameterPrefix: "pf_", website: "amazon"),
    TrackerParameter(parameterPrefix: "ref_", website: "amazon")
]
