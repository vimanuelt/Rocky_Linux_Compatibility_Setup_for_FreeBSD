#
# Makefile 
#

# Installation variables
PREFIX          ?= /usr/local
INSTALL_DIR     ?= $(PREFIX)/sbin

# Name of the script as it will be installed
SCRIPT_NAME     = setup_linux_compatibility.sh

# The actual script file in this repo
SCRIPT_FILE     = setup_linux_compatibility.sh

# Default installation and uninstallation targets
install:
	@echo "Installing $(SCRIPT_FILE) to $(DESTDIR)$(INSTALL_DIR)/$(SCRIPT_NAME)"
	@install -d "$(DESTDIR)$(INSTALL_DIR)"
	@install -m 0755 "$(SCRIPT_FILE)" "$(DESTDIR)$(INSTALL_DIR)/$(SCRIPT_NAME)"
	@echo "Installation complete."

uninstall:
	@echo "Removing $(DESTDIR)$(INSTALL_DIR)/$(SCRIPT_NAME)"
	@rm -f "$(DESTDIR)$(INSTALL_DIR)/$(SCRIPT_NAME)"
	@echo "Uninstall complete."

clean:
	@echo "Nothing to clean."

.PHONY: install uninstall clean

