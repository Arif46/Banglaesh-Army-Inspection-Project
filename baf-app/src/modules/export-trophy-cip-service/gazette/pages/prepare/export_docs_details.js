import i18n from '@/i18n'
import { saveAs } from 'file-saver'
import { AlignmentType, BorderStyle, convertInchesToTwip, Document, Packer, Paragraph, Table, TableCell, TableRow, WidthType, TextRun, ImageRun, VerticalAlign, TableBorders } from 'docx'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { gazetteDetailsApi } from '../../api/routes'
import Store from '@/store'

const exportDocxDetails = async (item, vm) => {
    function getName (item) {
      return i18n.locale === 'en' ? item.name_en : item.name_bn
    }
    function getDesignation (item) {
      return i18n.locale === 'en' ? item.org_info.designation_en : item.org_info.designation_bn
    }
    function getOrgnation (item) {
      return i18n.locale === 'en' ? item.org_info.org_name_en : item.org_info.org_name_bn
    }
    function getOrgName (item) {
      return i18n.locale === 'en' ? item.org_info.org_name_en : item.org_info.org_name_bn
    }
    function getTradeName (item) {
      return i18n.locale === 'en' ? item.name_en : item.name_bn
    }
    function getFbcciDesignation (item) {
      return i18n.locale === 'en' ? item.fbcci_designation_en + ', FBCCI' : item.fbcci_designation_bn + ', এফবিসিসিআই'
    }
    function getAssociation (item) {
      return i18n.locale === 'en' ? 'Representative ,' + item.referred_association_en : 'প্রতিনিধি ,' + item.referred_association_bn
    }
    function getTrophyName (trophy) {
      if (parseInt(trophy) === 1) {
        return vm.$t('exportTrophyConfig.gold')
      }
      if (parseInt(trophy) === 2) {
        return vm.$t('exportTrophyConfig.silver')
      }
      if (parseInt(trophy) === 3) {
        return vm.$t('exportTrophyConfig.bronze')
      }
    }

    // ET
    function getEtBodyValue (etSingleApps) {
      const allBodyRow = [
        new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('globalTrans.sl_no'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('exportTrophyGazette.trophy_receive_org_name'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('exportTrophyGazette.trophy_cat'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            })
          ]
        })
      ]
      etSingleApps.forEach((item, index) => {
        allBodyRow.push(new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$n(index + 1, { useGrouping: false }),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getOrgName(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: vm.getAddress(item.org_address),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: getTrophyName(item.trophy),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            })
          ]
        }))
      })
      return allBodyRow
    }

    function etTable (etApps) {
      const etAllTable = []
      let dataCount = 1
      for (const prop in etApps) {
        etAllTable.push(new Table({
          borders: TableBorders.NONE,
          rows: [
            new TableRow({
              children: [
                new TableCell({
                  children: [
                    new Paragraph({
                      alignment: AlignmentType.LEFT,
                      children: [
                        new TextRun({
                          text: '(' + vm.$n(dataCount++, { useGrouping: false }) + ') ' + vm.$t('exportTrophyGazette.product_sector') + ': ' + vm.getProductName(parseInt(prop)),
                          bold: true,
                          font: 'Nirmala UI',
                          size: 20
                        })
                      ]
                    })
                  ],
                  border: {
                    top: {
                      space: 20
                    }
                  }
                })
              ]
            })
          ],
          width: {
            size: 100,
            type: WidthType.PERCENTAGE
          }
        }))
        etAllTable.push(new Table({
          rows: [
          ...getEtBodyValue(etApps[prop])
          ],
          width: {
            size: 100,
            type: WidthType.PERCENTAGE
          }
        }))
        etAllTable.push(new Table({
          borders: TableBorders.NONE,
          rows: [
            new TableRow({
              children: [
                new TableCell({
                  children: [
                    new Paragraph({
                      alignment: AlignmentType.LEFT,
                      children: [
                        new TextRun({
                          text: '',
                          bold: true,
                          font: 'Nirmala UI',
                          size: 20
                        })
                      ]
                    })
                  ]
                })
              ]
            })
          ],
          width: {
            size: 100,
            type: WidthType.PERCENTAGE
          }
        }))
      }
      return etAllTable
    }

    // CIP Apps
    function getCipBodyValue (cipApps) {
      const allBodyRow = [
        new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('globalTrans.sl_no'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('exportTrophyGazette.name_designation_org_address'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('exportTrophyGazette.sector'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            })
          ]
        })
      ]
      cipApps.forEach((item, index) => {
        allBodyRow.push(new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$n(index + 1, { useGrouping: false }),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getName(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getDesignation(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getOrgnation(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: vm.getAddress(item.org_address),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.getProductName(item.product_service_sector_id),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            })
          ]
        }))
      })
      return allBodyRow
    }

    function cipTable (cipApplications) {
      return new Table({
        rows: [
        ...getCipBodyValue(cipApplications)
        ],
        width: {
          size: 100,
          type: WidthType.PERCENTAGE
        }
      })
    }

    // CIP Trades
    function getCipTradeBodyValue (cipTrades) {
      const allBodyRow = [
        new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('globalTrans.sl_no'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$t('exportTrophyGazette.name_designation_org'),
                      bold: true,
                      font: 'Nirmala UI',
                      size: 20
                    })
                  ]
                })
              ]
            })
          ]
        })
      ]
      cipTrades.forEach((item, index) => {
        allBodyRow.push(new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.CENTER,
                  children: [
                    new TextRun({
                      text: vm.$n(index + 1, { useGrouping: false }),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            }),
            new TableCell({
              children: [
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getTradeName(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getFbcciDesignation(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                }),
                new Paragraph({
                  alignment: AlignmentType.LEFT,
                  children: [
                    new TextRun({
                      text: getAssociation(item),
                      font: 'Nirmala UI',
                      size: 16
                    })
                  ]
                })
              ]
            })
          ]
        }))
      })
      return allBodyRow
    }

    function cipTradeTable (cipTrades) {
      return new Table({
        rows: [
        ...getCipTradeBodyValue(cipTrades) // ... three dot for comma separator.
        ],
        width: {
          size: 100,
          type: WidthType.PERCENTAGE
        }
      })
    }

    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      const params = Object.assign({}, { id: item.id, type: item.type, fiscal_year_id: item.fiscal_year_id, year: item.year })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, gazetteDetailsApi, params)
      const imageBase64Data = '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'
      const table1 = new Table({
        borders: TableBorders.NONE,
        rows: [
          new TableRow({
            children: [
              new TableCell({
                children: [
                  new Paragraph({
                    children: [
                      new TextRun({
                        text: vm.$t('exportTrophyGazette.registered_no') + '\t\t',
                        bold: true,
                        font: 'Nirmala UI',
                        size: 20
                      })
                    ]
                  })
                ]
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [
                      new TextRun({
                        text: vm.$t('exportTrophyGazette.slogan'),
                        bold: true,
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ]
                  })
                ]
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [
                      new TextRun({
                        text: '\t\t\t\t',
                        bold: true,
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ]
                  })
                ]
              })
            ]
          })
        ],
        width: {
          size: convertInchesToTwip(10.00),
          type: WidthType.AUTO
        }
      })
      const table2 = new Table({
        borders: TableBorders.NONE,
        rows: [
          new TableRow({
            children: [
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.RIGHT,
                    children: [
                      new TextRun({
                        text: vm.$t('exportTrophyGazette.country'),
                        bold: true,
                        font: 'Nirmala UI',
                        size: 30
                      })
                    ]
                  })
                ],
                verticalAlign: VerticalAlign.CENTER
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [
                      new ImageRun({
                        data: Buffer.from(imageBase64Data, 'base64'),
                        transformation: {
                          width: 70,
                          height: 70
                        }
                      })
                    ]
                  })
                ]
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.LEFT,
                    children: [
                      new TextRun({
                        text: vm.$t('exportTrophyGazette.gazette'),
                        bold: true,
                        font: 'Nirmala UI',
                        size: 30
                      })
                    ]
                  })
                ],
                verticalAlign: VerticalAlign.CENTER
              })
            ]
          })
        ],
        width: {
          size: convertInchesToTwip(6.00),
          type: WidthType.DXA
        }
      })
      const table3 = new Table({
        borders: TableBorders.NONE,
        rows: [
          new TableRow({
            children: [
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.LEFT,
                    children: [
                      new TextRun({
                        text: vm.$t('exportTrophyCircular.memo_no') + '-' + item.memo_no,
                        bold: true,
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ]
                  })
                ],
                verticalAlign: VerticalAlign.CENTER
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.RIGHT,
                    children: [
                      new TextRun({
                        text: '\t\t\t' + vm.$t('globalTrans.date') + ' : \t',
                        bold: true,
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ]
                  })
                ],
                verticalAlign: VerticalAlign.CENTER
              }),
              new TableCell({
                children: [
                  new Paragraph({
                    alignment: AlignmentType.LEFT,
                    children: [
                      new TextRun({
                        text: vm.getBnDateLocals(item),
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ],
                    border: {
                      bottom: {
                        color: 'auto',
                        space: 4,
                        style: BorderStyle.SINGLE,
                        size: 6
                      }
                    }
                  }),
                  new Paragraph({
                    alignment: AlignmentType.LEFT,
                    children: [
                      new TextRun({
                        text: vm.getDateLocalsTwo(item),
                        font: 'Nirmala UI',
                        size: 18
                      })
                    ]
                  })
                ]
              })
            ]
          })
        ],
        width: {
          size: convertInchesToTwip(6.00),
          type: WidthType.DXA
        }
      })

      // cip and et condition data
      const fiscalYear = (item.type === 2 && item.fiscal_year_id !== null) ? vm.getFiscalYear(item.fiscal_year_id) : ''
      const CIP = '  ' + vm.$t('globalTrans.date') + ' : ' + vm.getBnDateLocals(item) + ' / ' + vm.getDateLocalsTwo(item)
      const ET = '  ' + vm.$t('exportTrophyGazette.national_export_tropy') + ' ' + fiscalYear
      const cipETdata = new Paragraph({
        alignment: AlignmentType.CENTER,
        children: [
          new TextRun({
            text: (item.type === 1) ? CIP : ET,
            font: 'Nirmala UI',
            bold: true,
            size: 18
          })
        ],
        indent: {
          left: 300
        },
        border: {
          top: {
            space: 20
          }
        }
      })

      // title cip and et condition data
      const title = (vm.currentLocale === 'bn') ? item.title_bn : item.title_en
      const CIPTitle = item.memo_no + '-' + title
      const ETTitle = fiscalYear + ' ' + title
      const cipETtitle = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: (item.type === 1) ? CIPTitle : ETTitle,
            font: 'Nirmala UI',
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          },
          bottom: {
            space: 10
          }
        }
      })

      const cipAppsCount = (result.cipTrades) ? vm.$n(result.cipTrades.length, { useGrouping: false }) : 0
      const cipAppsMsg = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: vm.$t('exportTrophyGazette.cip_product_export') + ': ' + cipAppsCount,
            font: 'Nirmala UI',
            bold: true,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const cipTradesCount = (result.cipApplications) ? vm.$n(result.cipApplications.length, { useGrouping: false }) : 0
      const cipTradesMsg = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: vm.$t('exportTrophyGazette.cip_trade') + ': ' + cipTradesCount,
            font: 'Nirmala UI',
            bold: true,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const cipFacilityHeading = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: vm.$t('exportTrophyGazette.cip_facility'),
            font: 'Nirmala UI',
            bold: true,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const cipFacilityBody = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: i18n.locale === 'bn' ? item.cip_facilities_bn.replaceAll('<br />', '।') : item.cip_facilities_en.replaceAll('<br />', '।'),
            font: 'Nirmala UI',
            bold: false,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const cipTimelineHeading = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: vm.$t('exportTrophyGazette.cip_timeline'),
            font: 'Nirmala UI',
            bold: true,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const cipTimelineBody = new Paragraph({
        alignment: AlignmentType.LEFT,
        children: [
          new TextRun({
            text: i18n.locale === 'bn' ? item.timeline_bn.replaceAll('<br />', '।') : item.timeline_en.replaceAll('<br />', '।'),
            font: 'Nirmala UI',
            bold: false,
            size: 18
          })
        ],
        border: {
          top: {
            space: 8
          }
        }
      })

      const doc = new Document({
        sections: [
          {
            children: [
              table1,
              new Paragraph(''),
              table2,
              // অতিরিক্ত সংখ্যা
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.extra'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  top: {
                    space: 4
                  },
                  bottom: {
                    space: 4
                  }
                }
              }),
              // কর্তৃপক্ষ কর্তৃক প্রকাশিত
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.procasona'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  bottom: {
                    space: 10
                  }
                }
              }),
              // মঙ্গলবার, সেপ্টেম্বর ২৭, ২০২২
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: vm.getDayName(item) + ', ' + vm.getDateLocals(item),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 20
                  })
                ],
                border: {
                  top: {
                    color: 'auto',
                    space: 4,
                    style: BorderStyle.DOUBLE,
                    size: 6
                  },
                  bottom: {
                    color: 'auto',
                    space: 4,
                    style: BorderStyle.DOUBLE,
                    size: 6
                  }
                }
              }),
              // গনপ্রজাতন্ত্রী বাংলাদেশ সরকার
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.govt_name'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  top: {
                    space: 10
                  }
                }
              }),
              // বাণিজ্য মন্ত্রণালয়
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.ministry_name'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  top: {
                    space: 5
                  }
                }
              }),
              // রপ্তানি-৪ অধিশাখা
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.sub_section_name'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  top: {
                    space: 8
                  }
                }
              }),
              (item.type === 2) ? table3 : [],
              // প্রজ্ঞাপন
              new Paragraph({
                alignment: AlignmentType.CENTER,
                children: [
                  new TextRun({
                    text: '  ' + vm.$t('exportTrophyGazette.notification'),
                    font: 'Nirmala UI',
                    bold: true,
                    size: 18
                  })
                ],
                indent: {
                  left: 300
                },
                border: {
                  top: {
                    space: 8
                  }
                }
              }),
              // জাতীয় রপ্তানি ট্রফি ২০১৭-২০১৮ type = 2 for export trophy
              cipETdata,
              // টাইটেল
              cipETtitle,
              ...etTable(result.etApplications), // ... three dot for comma separator.
              (item.type === 1) ? cipAppsMsg : '',
              (item.type === 1) ? cipTable(result.cipApplications) : [],
              (item.type === 1) ? cipTradesMsg : '',
              (item.type === 1) ? cipTradeTable(result.cipTrades) : [],
              (item.type === 1) ? cipFacilityHeading : '',
              (item.type === 1) ? cipFacilityBody : '',
              (item.type === 1) ? cipTimelineHeading : '',
              (item.type === 1) ? cipTimelineBody : ''
            ]
          }
        ]
      })
      // Used to export the file into a .docx file
      Packer.toBlob(doc).then(blob => {
        saveAs(blob, 'gazette.docx')
      })

      vm.customloading = false
    } catch (error) {
      if (error) {}
    }
    Store.commit('mutateCommonProperties', {
      loading: false
    })
}
export default {
  exportDocxDetails
}
