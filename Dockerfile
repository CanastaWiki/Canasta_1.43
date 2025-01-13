FROM canasta-base AS base

LABEL maintainers=""
LABEL org.opencontainers.image.source=https://github.com/CanastaWiki/Canasta_1.43

COPY _sources/scripts/extensions-skins.php /tmp/
COPY _sources/patches/* /tmp/
COPY contents.yaml /tmp/
RUN php /tmp/extensions-skins.php"/tmp/contents.yaml"

# Default values
ENV MW_MAINTENANCE_CIRRUSSEARCH_UPDATECONFIG=2 \
	MW_MAINTENANCE_CIRRUSSEARCH_FORCEINDEX=2 \

# Dirty hack for Semantic MediaWiki
RUN set -x; \
	cd $MW_HOME/extensions \
	&& sed -i "s/#wfLoadExtension('SemanticMediaWiki');/#enableSemantics('localhost');/g" $MW_ORIGIN_FILES/installedExtensions.txt \