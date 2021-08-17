#
#
#

.SUFFIXES:
.PHONY: Makefile all assembly_line
all: assembly_line

#

# Make does not offer a recursive wildcard function, so here's one:
# From https://stackoverflow.com/questions/3774568/makefile-issue-smart-way-to-scan-directory-tree-for-c-files
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

#

define __dhall_resolve_immediate_dependencies
$(shell \
  $(DHALL) resolve \
		--immediate-dependencies \
		--file ${1} \
	| cut -d" " -f1 \
	| grep -v "^http" \
)
endef

#

define __nomalize_dhall_dependencies
$(shell realpath -e --relative-to=. "$(dir $(1))$(2)")
endef

#

define get_dependencies
$(foreach \
	dhall_dependency,
	$(call __dhall_resolve_immediate_dependencies,$(1)), \
	$(call __nomalize_dhall_dependencies,$(1),$(dhall_dependency)) \
)
endef

define hash_path
$(1:%.dhall=$(CACHE_DIR)/hash/%.hash)
endef

#

CACHE_DIR := ./.cache
DHALL := env XDG_CACHE_HOME=$(CACHE_DIR) dhall

ASSEMBLY_LINE_SRC=$(call rwildcard,dhall,*.dhall)
ASSEMBLY_LINE_HASH := $(call hash_path,${ASSEMBLY_LINE_SRC})

#
#
#

assembly_line: $(ASSEMBLY_LINE_HASH) .github/workflows/dhall.workflows.yaml

#
#
#

define make_assembly_targets
$(call hash_path,$(1)) : $(1) $(call hash_path,$(call get_dependencies,$(1)))
	$(DHALL) freeze --all --inplace $$<
	$(DHALL) format $$<
	$(DHALL) lint $$<
	$@mkdir -p $$(shell dirname "$$@")
	$(DHALL) hash --file $$< > $$@
endef

$(foreach file, $(ASSEMBLY_LINE_SRC),$(eval $(call make_assembly_targets,$(file))))
$(eval $(call make_assembly_targets,dhall/.github/workflows/ci.dhall))
