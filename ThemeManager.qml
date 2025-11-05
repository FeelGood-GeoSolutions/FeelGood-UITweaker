pragma ComponentBehavior: Bound
import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import org.qfield
import org.qgis
import Theme

Item {
    id: themeManager

    property bool systemDefaultDarkTheme: false
    property var systemDefaultColors: {}

    property var exposedColorConfig: ({
            // Brand
            "mainColor": {
                "group": "Brand",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Hauptfarbe",
                        "description": "Die Hauptfarbe der Benutzeroberfläche."
                    },
                    "en": {
                        "name": "Main Color",
                        "description": "The main color of the user interface."
                    }
                }
            },
            "mainColorSemiOpaque": {
                "group": "Brand",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Hauptfarbe (halbtransparent)",
                        "description": "Halbtransparente Variante der Hauptfarbe."
                    },
                    "en": {
                        "name": "Main Color (semi-opaque)",
                        "description": "Semi-opaque variant of the main color."
                    }
                }
            },
            "mainOverlayColor": {
                "group": "Brand",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Haupt-Overlay-Farbe",
                        "description": "Farbe von Haupt-Overlays und Abdeckungen."
                    },
                    "en": {
                        "name": "Main Overlay Color",
                        "description": "Color used for main overlays and covers."
                    }
                }
            },
            "accentColor": {
                "group": "Brand",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Akzentfarbe",
                        "description": "Prominente Akzentfarbe für wichtige Elemente."
                    },
                    "en": {
                        "name": "Accent Color",
                        "description": "Prominent accent color for key elements."
                    }
                }
            },
            "accentLightColor": {
                "group": "Brand",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Akzentfarbe (hell)",
                        "description": "Hellere/transparentere Variante der Akzentfarbe."
                    },
                    "en": {
                        "name": "Accent Color (light)",
                        "description": "Lighter/more transparent variant of the accent color."
                    }
                }
            },

            // Background
            "mainBackgroundColor": {
                "group": "Background",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Haupt-Hintergrund",
                        "description": "Standardhintergrund der Anwendung."
                    },
                    "en": {
                        "name": "Main Background",
                        "description": "Default background of the application."
                    }
                }
            },
            "mainBackgroundColorSemiOpaque": {
                "group": "Background",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Haupt-Hintergrund (halbtransparent)",
                        "description": "Halbtransparenter Haupt-Hintergrund."
                    },
                    "en": {
                        "name": "Main Background (semi-opaque)",
                        "description": "Semi-opaque main background color."
                    }
                }
            },
            "groupBoxBackgroundColor": {
                "group": "Background",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Gruppenfeld-Hintergrund",
                        "description": "Hintergrund von Gruppenfeldern."
                    },
                    "en": {
                        "name": "Group Box Background",
                        "description": "Background color of group boxes."
                    }
                }
            },
            "groupBoxSurfaceColor": {
                "group": "Background",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Gruppenfeld-Oberfläche",
                        "description": "Oberflächenfarbe von Gruppenfeldern."
                    },
                    "en": {
                        "name": "Group Box Surface",
                        "description": "Surface color of group boxes."
                    }
                }
            },
            "sensorBackgroundColor": {
                "group": "Background",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Sensor-Hintergrund",
                        "description": "Hintergrundfarbe für Sensordaten/Widgets."
                    },
                    "en": {
                        "name": "Sensor Background",
                        "description": "Background color for sensor data/widgets."
                    }
                }
            },

            // Text
            "mainTextColor": {
                "group": "Text",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Haupt-Textfarbe",
                        "description": "Primäre Textfarbe."
                    },
                    "en": {
                        "name": "Main Text Color",
                        "description": "Primary text color."
                    }
                }
            },
            "mainTextDisabledColor": {
                "group": "Text",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Text (deaktiviert)",
                        "description": "Textfarbe für deaktivierte Elemente."
                    },
                    "en": {
                        "name": "Text (disabled)",
                        "description": "Text color for disabled elements."
                    }
                }
            },
            "secondaryTextColor": {
                "group": "Text",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Sekundärtext",
                        "description": "Sekundäre/untergeordnete Textfarbe."
                    },
                    "en": {
                        "name": "Secondary Text",
                        "description": "Secondary/subdued text color."
                    }
                }
            },
            "buttonTextColor": {
                "group": "Text",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Schaltflächentext",
                        "description": "Textfarbe auf Schaltflächen."
                    },
                    "en": {
                        "name": "Button Text",
                        "description": "Text color used on buttons."
                    }
                }
            },

            // Controls
            "controlBackgroundColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Steuerelement-Hintergrund",
                        "description": "Hintergrund von Eingabe- und Steuerelementen."
                    },
                    "en": {
                        "name": "Control Background",
                        "description": "Background for input and control elements."
                    }
                }
            },
            "controlBackgroundAlternateColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Steuerelement-Hintergrund (alternativ)",
                        "description": "Alternative Hintergrundfarbe für Steuerelemente."
                    },
                    "en": {
                        "name": "Control Background (alternate)",
                        "description": "Alternate background for controls."
                    }
                }
            },
            "controlBackgroundDisabledColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Steuerelement-Hintergrund (deaktiviert)",
                        "description": "Hintergrundfarbe für deaktivierte Steuerelemente."
                    },
                    "en": {
                        "name": "Control Background (disabled)",
                        "description": "Background for disabled controls."
                    }
                }
            },
            "controlBorderColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Steuerelement-Rahmen",
                        "description": "Rahmenfarbe für Steuerelemente."
                    },
                    "en": {
                        "name": "Control Border",
                        "description": "Border color for controls."
                    }
                }
            },
            "toolButtonColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Werkzeugschaltfläche (Vordergrund)",
                        "description": "Icon-/Textfarbe von Werkzeugschaltflächen."
                    },
                    "en": {
                        "name": "Tool Button (foreground)",
                        "description": "Icon/text color of tool buttons."
                    }
                }
            },
            "toolButtonBackgroundColor": {
                "group": "Controls",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Werkzeugschaltfläche (Hintergrund)",
                        "description": "Hintergrund von Werkzeugschaltflächen."
                    },
                    "en": {
                        "name": "Tool Button Background",
                        "description": "Background for tool buttons."
                    }
                }
            },
            "toolButtonBackgroundSemiOpaqueColor": {
                "group": "Controls",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Werkzeugschaltfläche (Hintergrund, halbtransparent)",
                        "description": "Halbtransparenter Hintergrund für Werkzeugschaltflächen."
                    },
                    "en": {
                        "name": "Tool Button Background (semi-opaque)",
                        "description": "Semi-opaque background for tool buttons."
                    }
                }
            },
            "scrollBarBackgroundColor": {
                "group": "Controls",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Scrollbar-Hintergrund",
                        "description": "Hintergrund von Scrollleisten."
                    },
                    "en": {
                        "name": "Scrollbar Background",
                        "description": "Background of scrollbars."
                    }
                }
            },

            // Palette (neutrals)
            "darkRed": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Dunkelrot",
                        "description": "Dunkelrote Akzentfarbe."
                    },
                    "en": {
                        "name": "Dark Red",
                        "description": "Dark red accent color."
                    }
                }
            },
            "darkGray": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Dunkelgrau",
                        "description": "Dunkle Grauflächen und -texte."
                    },
                    "en": {
                        "name": "Dark Gray",
                        "description": "Dark gray for surfaces and text."
                    }
                }
            },
            "darkGraySemiOpaque": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Dunkelgrau (halbtransparent)",
                        "description": "Halbtransparente Variante von Dunkelgrau."
                    },
                    "en": {
                        "name": "Dark Gray (semi-opaque)",
                        "description": "Semi-opaque variant of dark gray."
                    }
                }
            },
            "gray": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Grau",
                        "description": "Neutrale Grautöne für UI-Elemente."
                    },
                    "en": {
                        "name": "Gray",
                        "description": "Neutral gray for UI elements."
                    }
                }
            },
            "lightGray": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Hellgrau",
                        "description": "Heller Grauton für Flächen und Linien."
                    },
                    "en": {
                        "name": "Light Gray",
                        "description": "Light gray for surfaces and lines."
                    }
                }
            },
            "lightestGray": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Sehr helles Grau",
                        "description": "Sehr heller Grauton für Hintergründe."
                    },
                    "en": {
                        "name": "Lightest Gray",
                        "description": "Very light gray for backgrounds."
                    }
                }
            },
            "lightestGraySemiOpaque": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Sehr helles Grau (halbtransparent)",
                        "description": "Halbtransparenter sehr heller Grauton."
                    },
                    "en": {
                        "name": "Lightest Gray (semi-opaque)",
                        "description": "Semi-opaque very light gray."
                    }
                }
            },
            "light": {
                "group": "Palette",
                "expose": false,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Weiß",
                        "description": "Reines Weiß für Flächen und Text."
                    },
                    "en": {
                        "name": "White",
                        "description": "Pure white for surfaces and text."
                    }
                }
            },

            // Status / Alerts
            "errorColor": {
                "group": "Status",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Fehler",
                        "description": "Farbe für Fehlermeldungen und negative Zustände."
                    },
                    "en": {
                        "name": "Error",
                        "description": "Color for errors and negative states."
                    }
                }
            },
            "warningColor": {
                "group": "Status",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Warnung",
                        "description": "Farbe für Warnungen und Hinweise."
                    },
                    "en": {
                        "name": "Warning",
                        "description": "Color for warnings and notices."
                    }
                }
            },
            "cloudColor": {
                "group": "Status",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Cloud",
                        "description": "Farbe für Cloud- und Sync-Elemente."
                    },
                    "en": {
                        "name": "Cloud",
                        "description": "Color used for cloud and sync elements."
                    }
                }
            },

            // Position & Accuracy
            "positionColor": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Position",
                        "description": "Farbe des Positionsindikators."
                    },
                    "en": {
                        "name": "Position",
                        "description": "Color of the position indicator."
                    }
                }
            },
            "positionColorSemiOpaque": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Position (halbtransparent)",
                        "description": "Halbtransparente Positionsfarbe."
                    },
                    "en": {
                        "name": "Position (semi-opaque)",
                        "description": "Semi-opaque position color."
                    }
                }
            },
            "positionBackgroundColor": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Positionshintergrund",
                        "description": "Hintergrundfarbe für Positionselemente."
                    },
                    "en": {
                        "name": "Position Background",
                        "description": "Background color for position-related elements."
                    }
                }
            },
            "darkPositionColor": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Position (dunkel)",
                        "description": "Dunkle Variante der Positionsfarbe."
                    },
                    "en": {
                        "name": "Position (dark)",
                        "description": "Dark variant of the position color."
                    }
                }
            },
            "darkPositionColorSemiOpaque": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Position (dunkel, halbtransparent)",
                        "description": "Halbtransparente dunkle Positionsfarbe."
                    },
                    "en": {
                        "name": "Position (dark, semi-opaque)",
                        "description": "Semi-opaque dark position color."
                    }
                }
            },
            "accuracyBad": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Genauigkeit – schlecht",
                        "description": "Farbe für schlechte Positionsgenauigkeit."
                    },
                    "en": {
                        "name": "Accuracy – bad",
                        "description": "Color for poor position accuracy."
                    }
                }
            },
            "accuracyTolerated": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Genauigkeit – toleriert",
                        "description": "Farbe für tolerierte Genauigkeit."
                    },
                    "en": {
                        "name": "Accuracy – tolerated",
                        "description": "Color for tolerated accuracy."
                    }
                }
            },
            "accuracyExcellent": {
                "group": "Position",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Genauigkeit – hervorragend",
                        "description": "Farbe für hervorragende Genauigkeit."
                    },
                    "en": {
                        "name": "Accuracy – excellent",
                        "description": "Color for excellent accuracy."
                    }
                }
            },

            // Navigation
            "navigationColor": {
                "group": "Navigation",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Navigation",
                        "description": "Farbe für Navigationspfade und -elemente."
                    },
                    "en": {
                        "name": "Navigation",
                        "description": "Color for navigation paths and elements."
                    }
                }
            },
            "navigationColorSemiOpaque": {
                "group": "Navigation",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Navigation (halbtransparent)",
                        "description": "Halbtransparente Navigationsfarbe."
                    },
                    "en": {
                        "name": "Navigation (semi-opaque)",
                        "description": "Semi-opaque navigation color."
                    }
                }
            },
            "navigationBackgroundColor": {
                "group": "Navigation",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Navigationshintergrund",
                        "description": "Hintergrundfarbe für Navigationselemente."
                    },
                    "en": {
                        "name": "Navigation Background",
                        "description": "Background color for navigation elements."
                    }
                }
            },

            // Bookmarks
            "bookmarkDefault": {
                "group": "Bookmarks",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Lesezeichen – Standard",
                        "description": "Standardfarbe für Lesezeichen."
                    },
                    "en": {
                        "name": "Bookmark – default",
                        "description": "Default bookmark color."
                    }
                }
            },
            "bookmarkOrange": {
                "group": "Bookmarks",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Lesezeichen – Orange",
                        "description": "Orangefarbene Lesezeichen."
                    },
                    "en": {
                        "name": "Bookmark – orange",
                        "description": "Orange bookmark color."
                    }
                }
            },
            "bookmarkRed": {
                "group": "Bookmarks",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Lesezeichen – Rot",
                        "description": "Rote Lesezeichen."
                    },
                    "en": {
                        "name": "Bookmark – red",
                        "description": "Red bookmark color."
                    }
                }
            },
            "bookmarkBlue": {
                "group": "Bookmarks",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Lesezeichen – Blau",
                        "description": "Blaue Lesezeichen."
                    },
                    "en": {
                        "name": "Bookmark – blue",
                        "description": "Blue bookmark color."
                    }
                }
            },

            // Editing
            "vertexColor": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt",
                        "description": "Farbe neuer/veränderlicher Stützpunkte."
                    },
                    "en": {
                        "name": "Vertex",
                        "description": "Color for editable vertices."
                    }
                }
            },
            "vertexColorSemiOpaque": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt (halbtransparent)",
                        "description": "Halbtransparente Stützpunktfarbe."
                    },
                    "en": {
                        "name": "Vertex (semi-opaque)",
                        "description": "Semi-opaque vertex color."
                    }
                }
            },
            "vertexSelectedColor": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt – ausgewählt",
                        "description": "Farbe ausgewählter Stützpunkte."
                    },
                    "en": {
                        "name": "Vertex – selected",
                        "description": "Color for selected vertices."
                    }
                }
            },
            "vertexSelectedColorSemiOpaque": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt – ausgewählt (halbtransparent)",
                        "description": "Halbtransparente Farbe ausgewählter Stützpunkte."
                    },
                    "en": {
                        "name": "Vertex – selected (semi-opaque)",
                        "description": "Semi-opaque color for selected vertices."
                    }
                }
            },
            "vertexNewColor": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt – neu",
                        "description": "Farbe neu erstellter Stützpunkte."
                    },
                    "en": {
                        "name": "Vertex – new",
                        "description": "Color for newly created vertices."
                    }
                }
            },
            "vertexNewColorSemiOpaque": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Stützpunkt – neu (halbtransparent)",
                        "description": "Halbtransparente Farbe neuer Stützpunkte."
                    },
                    "en": {
                        "name": "Vertex – new (semi-opaque)",
                        "description": "Semi-opaque color for new vertices."
                    }
                }
            },
            "processingPreview": {
                "group": "Editing",
                "expose": true,
                "showDescription": false,
                "translations": {
                    "de": {
                        "name": "Verarbeitungs‑Vorschau",
                        "description": "Farbe für Vorschauen in Verarbeitung/Analyse."
                    },
                    "en": {
                        "name": "Processing preview",
                        "description": "Color used for processing/analysis previews."
                    }
                }
            }
        })

    Settings {
        id: themeManagerSettings
        property bool useDarkTheme: false
        property var customColors: {}

        function setColor(name, value) {
            var c = Object.assign({}, customColors);
            c[name] = value;
            customColors = c; // triggers colorsChanged, bindings re-evaluate
        }
    }

    function colorTranslation(key, lang) {
        try {
            var cfg = themeManager && themeManager.exposedColorConfig ? themeManager.exposedColorConfig : {};
            var entry = cfg[key];
            if (!entry)
                return {
                    name: key,
                    description: ""
                };
            var dict = entry.translations || {};
            var hasLang = (typeof lang === 'string') && (lang !== '');
            var preferred = hasLang ? lang : (function () {
                    try {
                        var ql = Qt.locale();
                        if (ql && ql.name) {
                            var base = String(ql.name).split('_')[0];
                            if (base)
                                return base;
                        }
                    } catch (eInner) {}
                    return 'en';
                })();
            var trans = dict[preferred] || dict['en'];
            if (!trans) {
                var locales = Object.keys(dict);
                if (locales.length > 0)
                    trans = dict[locales[0]];
            }
            if (trans)
                return {
                    name: trans.name || key,
                    description: trans.description || ""
                };
        } catch (e) {}
        return {
            name: key,
            description: ""
        };
    }

    property var colorKeys: Object.keys(exposedColorConfig).filter(function (k) {
        var e = exposedColorConfig[k];
        return e && e.expose === true;
    })

    property var colorGroups: {
        var cfg = exposedColorConfig || {};
        var keys = colorKeys || [];
        var order = [];
        var groups = {};
        for (var i = 0; i < keys.length; ++i) {
            var key = keys[i];
            var entry = cfg[key] || {};
            var groupName = entry.group || qsTr("Other");
            if (!groups[groupName]) {
                groups[groupName] = [];
                order.push(groupName);
            }
            groups[groupName].push(key);
        }
        var result = [];
        for (var j = 0; j < order.length; ++j) {
            var groupKey = order[j];
            result.push({
                name: groupKey,
                keys: groups[groupKey]
            });
        }
        return result;
    }

    function keyToLabel(key) {
        return ((themeManager.colorTranslation && themeManager.colorTranslation(key)) || {
                name: key
            }).name;
    }

    function readTheme(key) {
        try {
            return Theme[key];
        } catch (e) {
            return "";
        }
    }

    Component.onCompleted: {
        try {
            themeDialog.parent = iface.mainWindow().contentItem;
        } catch (e) {}

        var c = Object.assign({}, systemDefaultColors);
        for ( var k in exposedColorConfig ) {
            var themeColor = readTheme(k);
            c[k] = colorToString(themeColor);
        }
        systemDefaultColors = c; // triggers colorsChanged, bindings re-evaluate
    }

    Popup {
        id: themeDialog
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        width: Math.min(640, (parent ? parent.width * 0.9 : 640))
        height: Math.min((parent ? parent.height * 0.85 : 720), 720)
        anchors.centerIn: parent

        palette.text: Theme.mainTextColor
        palette.base: Theme.controlBackgroundColor
        palette.buttonText: Theme.buttonTextColor

        background: Rectangle {
            color: Theme.mainBackgroundColor
            radius: 8
            border.color: Theme.controlBorderColor
        }

        contentItem: ColumnLayout {
            spacing: 12
            anchors.fill: parent
            anchors.margins: 12

            ColumnLayout {
                id: header
                Layout.fillWidth: true
                spacing: 6

                property bool wrap: (oneLineHeader.implicitWidth > width)

                RowLayout {
                    id: oneLineHeader
                    Layout.fillWidth: true
                    spacing: 8
                    visible: !header.wrap
                    Layout.preferredHeight: visible ? implicitHeight : 0

                    Label {
                        id: titleOneLine
                        text: "Theme Colors"
                        font.pixelSize: 18
                        color: Theme.mainTextColor
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "X"
                        onClicked: themeDialog.close()
                    }

                    RowLayout {
                        id: buttonsOneLine
                        spacing: 6
                        Button {
                            text: "Import/Export"
                            enabled: false
                            visible: false
                            onClicked: {}
                        }
                        Button {
                            text: "Reset"
                            onClicked: {
                                Theme.applyColors(themeManager.systemDefaultColors);
                                themeManagerSettings.customColors = {};
                            }
                        }
                    }
                }

                ColumnLayout {
                    id: wrappedHeader
                    Layout.fillWidth: true
                    spacing: 6
                    visible: header.wrap
                    Layout.preferredHeight: visible ? implicitHeight : 0

                    Label {
                        id: titleWrapped
                        text: "Theme Colors"
                        color: Theme.mainTextColor
                        Layout.fillWidth: true
                    }
                    Button {
                        text: "X"
                        onClicked: themeDialog.close()
                    }
                    Flow {
                        id: buttonsWrapped
                        spacing: 6
                        Layout.fillWidth: true
                        // Let buttons wrap onto additional lines when space is tight
                        flow: Flow.LeftToRight

                        Button {
                            text: "Import/Export"
                            enabled: false
                            visible: false
                            onClicked: {}
                        }
                        Button {
                            text: "Reset"
                            onClicked: {
                                Theme.applyColors(themeManager.systemDefaultColors);
                                themeManagerSettings.customColors = {};
                            }
                        }
                    }
                }
            }

            // generate grouped lines for each exposed color
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                contentWidth: width
                contentHeight: colorList.implicitHeight

                Column {
                    id: colorList
                    width: parent.width
                    spacing: 12
                    Repeater {
                        id: colorGroupsRepeater
                        model: themeManager.colorGroups
                        delegate: Column {
                            id: groupSection
                            required property var modelData
                            property var groupData: modelData
                            width: parent ? parent.width : 0
                            spacing: 6

                            Label {
                                text: groupSection.groupData.name
                                color: Theme.secondaryTextColor
                                font.bold: true
                                font.pixelSize: 14
                            }

                            Column {
                                id: groupColors
                                width: parent.width
                                spacing: 6
                                Repeater {
                                    model: groupSection.groupData.keys
                                    delegate: Item {
                                        id: colorRowRoot
                                        required property int index
                                        property string key: groupSection.groupData.keys[index]
                                        property string label: themeManager.keyToLabel(key)
                                        property string currentColorStr: themeManager.colorToString(themeManager.readTheme(key))
                                        property color colorObj: currentColorStr

                                        width: parent ? parent.width : 0
                                        height: columnLayout.implicitHeight

                                        ColumnLayout {
                                            id: columnLayout
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            spacing: 4

                                            // First row: color swatch + name
                                            RowLayout {
                                                Layout.fillWidth: true
                                                spacing: 8

                                                Rectangle {
                                                    radius: 4
                                                    color: colorRowRoot.currentColorStr
                                                    border.color: Theme.controlBorderColor
                                                    Layout.preferredWidth: 28
                                                    Layout.preferredHeight: 28
                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onClicked: colorDialog.open()
                                                    }
                                                }

                                                Label {
                                                    text: colorRowRoot.label
                                                    color: Theme.mainTextColor
                                                    Layout.fillWidth: true
                                                    elide: Text.ElideRight
                                                }
                                            }

                                            // Second row: text field + pick button
                                            RowLayout {
                                                Layout.fillWidth: true
                                                spacing: 4
                                                // Height fits tallest control in the row
                                                Layout.preferredHeight: Math.max(hexField.implicitHeight, pickButton.implicitHeight)

                                                TextField {
                                                    id: hexField
                                                    Layout.fillWidth: true
                                                    Layout.minimumWidth: 0
                                                    text: colorRowRoot.currentColorStr
                                                    color: Theme.mainTextColor
                                                    placeholderText: "#RRGGBB"
                                                    placeholderTextColor: Theme.secondaryTextColor
                                                    selectionColor: Theme.accentColor
                                                    selectedTextColor: Theme.light
                                                    implicitWidth: 0
                                                    onAccepted: {
                                                        if (text && text.length > 0) {
                                                            // Do not assign to currentColorStr to preserve its binding to Theme
                                                            themeManagerSettings.setColor(colorRowRoot.key, text);
                                                            Theme.applyColors(themeManagerSettings.customColors);
                                                        }
                                                    }
                                                    onEditingFinished: {
                                                        if (text && text.length > 0) {
                                                            // Do not assign to currentColorStr to preserve its binding to Theme
                                                            themeManagerSettings.setColor(colorRowRoot.key, text);
                                                            Theme.applyColors(themeManagerSettings.customColors);
                                                        }
                                                    }
                                                    background: Rectangle {
                                                        implicitWidth: 0
                                                        radius: 4
                                                        color: Theme.controlBackgroundColor
                                                        border.color: Theme.controlBorderColor
                                                    }
                                                }

                                                Button {
                                                    id: pickButton
                                                    text: "Pick"
                                                    Layout.preferredWidth: 50
                                                    onClicked: colorDialog.open()
                                                }
                                            }

                                            ColorDialog {
                                                id: colorDialog
                                                title: colorRowRoot.label
                                                // Bind directly to the live theme color so the dialog always reflects current state
                                                selectedColor: themeManager.readTheme(colorRowRoot.key)
                                                options: ColorDialog.ShowAlphaChannel

                                                onAccepted: {
                                                    const selStr = themeManager.colorToString(selectedColor);
                                                    themeManagerSettings.setColor(colorRowRoot.key, selStr);
                                                    Theme.applyColors(themeManagerSettings.customColors);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function openThemeDialog() {
        themeDialog.open();
    }

    function log(msg) {
        //dont change this. This works. Console.log() does not!
        iface.logMessage("FeelGood UI-Tweaker - Theme Manager: " + msg);
    }

    function colorToString(val) {
        if (val === undefined || val === null)
            return "";
        if (typeof val === "string")
            return val;
        if (typeof val === 'object') {
            let r = val.r !== undefined ? val.r : (val.red !== undefined ? val.red : undefined);
            let g = val.g !== undefined ? val.g : (val.green !== undefined ? val.green : undefined);
            let b = val.b !== undefined ? val.b : (val.blue !== undefined ? val.blue : undefined);
            let a = val.a !== undefined ? val.a : (val.alpha !== undefined ? val.alpha : 1);
            if (r !== undefined && g !== undefined && b !== undefined) {
                function toHex(n) {
                    n = Math.max(0, Math.min(255, Math.round(n)));
                    return (n < 16 ? '0' : '') + n.toString(16);
                }
                const rr = toHex(r <= 1 ? r * 255 : r);
                const gg = toHex(g <= 1 ? g * 255 : g);
                const bb = toHex(b <= 1 ? b * 255 : b);
                const aa = toHex((a === undefined ? 255 : (a <= 1 ? a * 255 : a)));
                if (aa !== 'ff')
                    return '#' + aa + rr + gg + bb;
                return '#' + rr + gg + bb;
            }
        }
        return "" + val;
    }
}
