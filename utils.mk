# vars for use by utils
colon := $(empty):$(empty)
underscore := $(empty)_$(empty)

# $(call match-word-in-list,w,wlist)
# does an exact match of word w in word list wlist
# How it works
#   if the input word is not empty
#     return output of an exact match of word w in wordlist wlist
#   else
#     return empty
# returns true or empty
define match-word-in-list
$(strip \
  $(if $(strip $(1)), \
    $(call match-word,$(call find-word-in-list,$(1),$(2)),$(strip $(1))), \
  ) \
)
endef

# $(call is-board-platform-in-list,bpl)
# returns true or empty
define is-board-platform-in-list2
$(call match-word-in-list,$(TARGET_BOARD_PLATFORM),$(1))
endef
