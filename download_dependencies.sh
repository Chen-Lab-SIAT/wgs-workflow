#!/bin/bash

# 文件URL
GENOME_URL="https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta"
DBSNP_URL="https://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606/VCF/v146/00-All.vcf.gz"
MILLS_1000G_URL="https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz"
KNOWN_INDELS_URL="https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz"
SNPEFF_CONFIG_URL="https://sourceforge.net/projects/snpeff/files/snpEff_v5_0_core.zip"
SNPEFF_JAR_URL="https://sourceforge.net/projects/snpeff/files/snpEff_v5_0_core.zip"
JAVA_URL="https://download.oracle.com/java/19/archive/jdk-19.0.2_linux-x64_bin.tar.gz"

# 目标下载目录
TARGET_DIR="./downloads"

# 创建下载目录如果不存在
mkdir -p $TARGET_DIR

# 下载文件
curl -o "$TARGET_DIR/Homo_sapiens_assembly38.fasta" "$GENOME_URL"
curl -o "$TARGET_DIR/dbsnp_146.hg38.vcf.gz" "$DBSNP_URL"
curl -o "$TARGET_DIR/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz" "$MILLS_1000G_URL"
curl -o "$TARGET_DIR/Homo_sapiens_assembly38.known_indels.vcf.gz" "$KNOWN_INDELS_URL"
curl -L -o "$TARGET_DIR/snpEff.zip" "$SNPEFF_CONFIG_URL"
unzip -o "$TARGET_DIR/snpEff.zip" -d "$TARGET_DIR"
curl -L -o "$TARGET_DIR/jdk-19.0.2.tar.gz" "$JAVA_URL"
tar -xzf "$TARGET_DIR/jdk-19.0.2.tar.gz" -C "$TARGET_DIR"

# 验证下载是否成功
for FILE in "Homo_sapiens_assembly38.fasta" "dbsnp_146.hg38.vcf.gz" "Mills_and_1000G_gold_standard.indels.hg38.vcf.gz" "Homo_sapiens_assembly38.known_indels.vcf.gz" "snpEff/config" "snpEff/snpEff.jar"; do
    if [[ -f "$TARGET_DIR/$FILE" ]]; then
        echo "$FILE downloaded successfully."
    else
        echo "Error downloading $FILE."
    fi
done

# 添加JAVA到PATH
export PATH=$TARGET_DIR/jdk-19.0.2/bin:$PATH
echo "Java path set to $TARGET_DIR/jdk-19.0.2/bin"

echo "All files are downloaded and Java path is set."
