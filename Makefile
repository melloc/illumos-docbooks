#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright (c) 2012, Joyent, Inc.
#

XSLT_FILES=$(shell find src/xslt)
WDD_XML_FILES=$(shell find raw/wdd/ -name \*.xml)
ZFS_XML_FILES=$(shell find raw/zfs-admin/ -name \*.xml)
MDB_XML_FILES=$(shell find raw/mdb/ -name \*.xml)
DTRACE_XML_FILES=$(shell find raw/dtrace/ -name \*.xml)
LGRPS_XML_FILES=$(shell find raw/lgrps/ -name \*.xml)

DBLATEX=dblatex
DBLATEX_OPTS=-P latex.output.revhistory=0 -P doc.collab.show=0

build/lgrps: ${LGRPS_XML_FILES} ${XSLT_FILES}
	rm -rf $@
	mvn -q -Dtarget.book=lgrps xml:transform
	cp src/xslt/style.css $@
	${DBLATEX} ${DBLATEX_OPTS} -o build/lgrps/lgrps.pdf raw/lgrps/MTPODG.book

build/zfs-admin: ${ZFS_XML_FILES} ${XSLT_FILES}
	rm -rf $@
	mvn -q -Dtarget.book=zfs-admin xml:transform
	cp src/xslt/style.css $@
	${DBLATEX} ${DBLATEX_OPTS} -o build/zfs-admin/zfs-admin.pdf raw/zfs-admin/ZFSADMIN.book

build/wdd: ${WDD_XML_FILES} ${XSLT_FILES}
	rm -rf $@
	mvn -q -Dtarget.book=wdd xml:transform
	cp src/xslt/style.css $@
	${DBLATEX} ${DBLATEX_OPTS} -o build/wdd/wdd.pdf raw/wdd/DRIVER.book

build/dtrace: ${DTRACE_XML_FILES} ${XSLT_FILES}
	rm -rf $@
	mvn -q -Dtarget.book=dtrace xml:transform
	cp src/xslt/style.css $@
	${DBLATEX} ${DBLATEX_OPTS} -o build/dtrace/dtrace.pdf raw/dtrace/DYNMCTRCGGD.book

build/mdb: ${MDB_XML_FILES} ${XSLT_FILES}
	rm -rf $@
	mvn -q -Dtarget.book=mdb xml:transform
	cp src/xslt/style.css $@
	${DBLATEX} ${DBLATEX_OPTS} -o build/mdb/mdb.pdf raw/mdb/MODDEBUG.book

all: build/lgrps build/zfs-admin build/wdd build/dtrace build/mdb

clean:
	rm -rf build/

check:
	mvn exec:java
