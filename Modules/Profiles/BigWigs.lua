local TXUI, F, E, I, V, P, G = unpack(select(2, ...))
local PF = TXUI:GetModule("Profiles")

local GetRealmName = GetRealmName
local UnitName = UnitName

function PF:BuildBigWigsProfile()
  local pf = {}
  local profileName = I.ProfileNames[E.db.TXUI.installer.layout]

  F.Table.Crush(pf, {
    ["namespaces"] = {
      ["BigWigs_Plugins_AltPower"] = {
        ["profiles"] = {
          [profileName] = {
            ["additionalWidth"] = 28,
            ["backgroundColor"] = {
              [4] = 0.31,
            },
            ["fontName"] = F.FontOverride(I.Fonts.PrimaryBold),
            ["fontSize"] = 14,
            ["position"] = {
              [3] = -392,
              [4] = -392,
            },
          },
        },
      },
      ["BigWigs_Plugins_AutoReply"] = {
        ["profiles"] = {
          [profileName] = {
            ["disabled"] = false,
            ["exitCombat"] = 4,
            ["mode"] = 4,
          },
        },
      },
      ["BigWigs_Plugins_Bars"] = {
        ["profiles"] = {
          [profileName] = {
            ["BigWigsAnchor_height"] = 26,
            ["BigWigsAnchor_width"] = 285,
            ["BigWigsAnchor_x"] = 1190,
            ["BigWigsAnchor_y"] = 230,
            ["BigWigsEmphasizeAnchor_height"] = 26,
            ["BigWigsEmphasizeAnchor_width"] = 274,
            ["BigWigsEmphasizeAnchor_x"] = 810,
            ["BigWigsEmphasizeAnchor_y"] = 300,
            ["alignText"] = "RIGHT",
            ["alignTime"] = "LEFT",
            ["barStyle"] = "ElvUI",
            ["emphasizeGrowup"] = true,
            ["emphasizeTime"] = 10,
            ["fill"] = true,
            ["fontName"] = "- M 700",
            ["fontSize"] = 16,
            ["fontSizeEmph"] = 16,
            ["fontSizeNameplate"] = 12,
            ["growup"] = true,
            ["iconPosition"] = "RIGHT",
            ["outline"] = "OUTLINE",
            ["spacing"] = 5,
            ["texture"] = "- Tx Left",
            ["visibleBarLimit"] = 8,
            ["visibleBarLimitEmph"] = 8,
          },
        },
      },
      ["BigWigs_Plugins_Colors"] = {
        ["profiles"] = {
          [profileName] = {
            ["barColor"] = {
              ["BigWigs_Plugins_Colors"] = {
                ["default"] = {
                  [1] = 0.01,
                  [2] = 0.63,
                  [3] = 0.93,
                },
              },
            },
            ["barEmphasized"] = {
              ["BigWigs_Plugins_Colors"] = {
                ["default"] = {
                  [1] = 0.97,
                  [2] = 0.09,
                  [3] = 0.56,
                },
              },
            },
            ["red"] = {
              ["BigWigs_Plugins_Colors"] = {
                ["default"] = {
                  [1] = 0.7,
                  [2] = 0.14,
                  [3] = 0.14,
                  [4] = 1,
                },
              },
            },
          },
        },
      },
      ["BigWigs_Plugins_Countdown"] = {
        ["profiles"] = {
          [profileName] = {
            ["fontColor"] = {
              ["b"] = 0.3,
            },
            ["fontName"] = F.FontOverride(I.Fonts.BigNumber),
            ["fontSize"] = 100,
            ["position"] = {
              [1] = "CENTER",
              [2] = "CENTER",
              [4] = -150,
            },
            ["voice"] = "enUS: Default (Male)",
          },
        },
      },
      ["BigWigs_Plugins_InfoBox"] = {
        ["profiles"] = {
          [profileName] = {
            ["posx"] = 310,
            ["posy"] = 207,
          },
        },
      },
      ["BigWigs_Plugins_Messages"] = {
        ["profiles"] = {
          [profileName] = {
            ["align"] = "RIGHT",
            ["emphFontName"] = F.FontOverride(I.Fonts.Title),
            ["emphFontSize"] = 40,
            ["emphPosition"] = {
              [1] = "TOP",
              [2] = "TOP",
              [4] = -215,
            },
            ["emphUppercase"] = false,
            ["fontName"] = "- M 700",
            ["fontSize"] = 30,
            ["normalPosition"] = {
              [1] = "CENTER",
              [2] = "CENTER",
              [3] = -340,
              [4] = -163,
            },
            ["outline"] = "OUTLINE",
          },
        },
      },
      ["BigWigs_Plugins_Proximity"] = {
        ["profiles"] = {
          [profileName] = {
            ["fontName"] = F.FontOverride(I.Fonts.Title),
            ["fontSize"] = 24,
            ["objects"] = {
              ["ability"] = false,
              ["close"] = false,
              ["sound"] = false,
            },
            ["posx"] = 845,
            ["posy"] = 155,
          },
        },
      },
      ["BigWigs_Plugins_Pull"] = {
        ["profiles"] = {
          [profileName] = {
            ["voice"] = "English: Jim",
          },
        },
      },
      ["BigWigs_Plugins_Wipe"] = {
        ["profiles"] = {
          [profileName] = {
            ["wipeSound"] = "Awww Crap",
          },
        },
      },
    },
  })

  if F.HiDpi() then
    if E.db.TXUI.installer.layout == I.Enum.Layouts.HEALER then -- Move Anchor for Healer layout
      pf["namespaces"]["BigWigs_Plugins_Bars"]["profiles"][profileName]["BigWigsEmphasizeAnchor_y"] = 315
    end
  else
    if E.db.TXUI.installer.layout == I.Enum.Layouts.HEALER then
      self:LogWarning("Sorry, we don't have a 1080p profile yet for healers")
    else
      self:LogWarning("Sorry, we don't have a 1080p profile yet for dps")
    end
  end

  -- Those are not included in the export, change manually if needed
  pf["profiles"] = {}
  pf["profiles"][profileName] = {}
  pf["profiles"][profileName]["showZoneMessages"] = true
  pf["profiles"][profileName]["flash"] = true
  pf["profiles"][profileName]["fakeDBMVersion"] = true

  -- ! Personal change
  if F.DevBuildBigWigsProfile then F.Table.Crush(pf, F.DevBuildBigWigsProfile(pf)) end

  return pf
end

function PF:BigWigs_Private()
  -- Get table name
  local dbName = TXUI.IsRetail and "BigWigs3DB" or "BigWigsClassicDB"

  -- Create Table if they don't exist
  _G[dbName] = _G[dbName] or {}
  _G[dbName].profileKeys = _G[dbName].profileKeys or {}

  -- Create a profile key for the current player
  local name = UnitName("player")
  local realm = GetRealmName()

  -- Set our profile as preffered
  _G[dbName].profileKeys[name .. " - " .. realm] = I.ProfileNames[E.db.TXUI.installer.layout]
end

function PF:MergeBigWigsProfile()
  -- Get table names
  local dbName = TXUI.IsRetail and "BigWigs3DB" or "BigWigsClassicDB"
  local dbIconName = TXUI.IsRetail and "BigWigsIconDB" or "BigWigsIconClassicDB"

  -- Create Tables if they don't exist
  _G[dbName] = _G[dbName] or {}
  _G[dbIconName] = _G[dbIconName] or {}

  -- Build BigWigs Profile
  local pf = self:BuildBigWigsProfile()

  -- Merge Tablee
  F.Table.Crush(_G[dbName], pf)

  -- Hide minimap icon
  _G[dbIconName].hide = true

  -- Create key for character
  self:BigWigs_Private()
end
