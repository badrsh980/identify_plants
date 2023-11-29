class PlantIdentificationResponse {
  final String? accessToken;
  final String? modelVersion;
  final dynamic customId;
  final PlantIdentificationInput? input;
  final PlantIdentificationResult? result;
  final String? status;
  final bool? slaCompliantClient;
  final bool? slaCompliantSystem;
  final double? created;
  final double? completed;

  PlantIdentificationResponse({
    this.accessToken,
    this.modelVersion,
    this.customId,
    this.input,
    this.result,
    this.status,
    this.slaCompliantClient,
    this.slaCompliantSystem,
    this.created,
    this.completed,
  });

  factory PlantIdentificationResponse.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationResponse(
        accessToken: json['access_token'],
        modelVersion: json['model_version'],
        customId: json['custom_id'],
        input: json['input'] != null
            ? PlantIdentificationInput.fromJson(json['input'])
            : null,
        result: json['result'] != null
            ? PlantIdentificationResult.fromJson(json['result'])
            : null,
        status: json['status'],
        slaCompliantClient: json['sla_compliant_client'],
        slaCompliantSystem: json['sla_compliant_system'],
        created: json['created']?.toDouble(),
        completed: json['completed']?.toDouble(),
      );
}

class PlantIdentificationInput {
  final List<String>? images;
  final String? datetime;
  final double? latitude;
  final double? longitude;
  final bool? similarImages;

  PlantIdentificationInput({
    this.images,
    this.datetime,
    this.latitude,
    this.longitude,
    this.similarImages,
  });

  factory PlantIdentificationInput.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationInput(
        images: json['images']?.cast<String>(),
        datetime: json['datetime'],
        latitude: json['latitude']?.toDouble(),
        longitude: json['longitude']?.toDouble(),
        similarImages: json['similar_images'],
      );
}

class PlantIdentificationResult {
  final PlantIdentificationIsPlant? isPlant;
  final PlantIdentificationClassification? classification;

  PlantIdentificationResult({
    this.isPlant,
    this.classification,
  });

  factory PlantIdentificationResult.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationResult(
        isPlant: json['is_plant'] != null
            ? PlantIdentificationIsPlant.fromJson(json['is_plant'])
            : null,
        classification: json['classification'] != null
            ? PlantIdentificationClassification.fromJson(json['classification'])
            : null,
      );
}

class PlantIdentificationIsPlant {
  final bool? binary;
  final double? threshold;
  final double? probability;

  PlantIdentificationIsPlant({
    this.binary,
    this.threshold,
    this.probability,
  });

  factory PlantIdentificationIsPlant.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationIsPlant(
        binary: json['binary'],
        threshold: json['threshold']?.toDouble(),
        probability: json['probability']?.toDouble(),
      );
}

class PlantIdentificationClassification {
  final List<PlantIdentificationSuggestion>? suggestions;

  PlantIdentificationClassification({this.suggestions});

  factory PlantIdentificationClassification.fromJson(
          Map<String, dynamic> json) =>
      PlantIdentificationClassification(
        suggestions: json['suggestions'] != null
            ? List<PlantIdentificationSuggestion>.from(json['suggestions']
                .map((x) => PlantIdentificationSuggestion.fromJson(x)))
            : null,
      );
}

class PlantIdentificationSuggestion {
  final String? id;
  final String? name;
  final double? probability;
  final List<PlantIdentificationSimilarImage>? similarImages;
  final PlantIdentificationDetails? details;

  PlantIdentificationSuggestion({
    this.id,
    this.name,
    this.probability,
    this.similarImages,
    this.details,
  });

  factory PlantIdentificationSuggestion.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationSuggestion(
        id: json['id'],
        name: json['name'],
        probability: json['probability']?.toDouble(),
        similarImages: json['similar_images'] != null
            ? List<PlantIdentificationSimilarImage>.from(json['similar_images']
                .map((x) => PlantIdentificationSimilarImage.fromJson(x)))
            : null,
        details: json['details'] != null
            ? PlantIdentificationDetails.fromJson(json['details'])
            : null,
      );
}

class PlantIdentificationSimilarImage {
  final String? id;
  final String? url;
  final String? licenseName;
  final String? licenseUrl;
  final String? citation;
  final double? similarity;
  final String? urlSmall;

  PlantIdentificationSimilarImage({
    this.id,
    this.url,
    this.licenseName,
    this.licenseUrl,
    this.citation,
    this.similarity,
    this.urlSmall,
  });

  factory PlantIdentificationSimilarImage.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationSimilarImage(
        id: json['id'],
        url: json['url'],
        licenseName: json['license_name'],
        licenseUrl: json['license_url'],
        citation: json['citation'],
        similarity: json['similarity']?.toDouble(),
        urlSmall: json['url_small'],
      );
}

class PlantIdentificationDetails {
  final List<String>? commonNames;
  final PlantIdentificationTaxonomy? taxonomy;
  final String? url;
  final int? gbifId;
  final int? inaturalistId;
  final String? rank;
  final PlantIdentificationDescription? description;
  final List<String>? synonyms;
  final PlantIdentificationImage? image;

  PlantIdentificationDetails({
    this.commonNames,
    this.taxonomy,
    this.url,
    this.gbifId,
    this.inaturalistId,
    this.rank,
    this.description,
    this.synonyms,
    this.image,
  });

  factory PlantIdentificationDetails.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationDetails(
        commonNames: json['common_names']?.cast<String>(),
        taxonomy: json['taxonomy'] != null
            ? PlantIdentificationTaxonomy.fromJson(json['taxonomy'])
            : null,
        url: json['url'],
        gbifId: json['gbif_id'],
        inaturalistId: json['inaturalist_id'],
        rank: json['rank'],
        description: json['description'] != null
            ? PlantIdentificationDescription.fromJson(json['description'])
            : null,
        synonyms: json['synonyms']?.cast<String>(),
        image: json['image'] != null
            ? PlantIdentificationImage.fromJson(json['image'])
            : null,
      );
}

class PlantIdentificationTaxonomy {
  final String? plantClass;
  final String? genus;
  final String? order;
  final String? family;
  final String? phylum;
  final String? kingdom;

  PlantIdentificationTaxonomy({
    this.plantClass,
    this.genus,
    this.order,
    this.family,
    this.phylum,
    this.kingdom,
  });

  factory PlantIdentificationTaxonomy.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationTaxonomy(
        plantClass: json['class'],
        genus: json['genus'],
        order: json['order'],
        family: json['family'],
        phylum: json['phylum'],
        kingdom: json['kingdom'],
      );
}

class PlantIdentificationDescription {
  final String? value;
  final String? citation;
  final String? licenseName;
  final String? licenseUrl;

  PlantIdentificationDescription({
    this.value,
    this.citation,
    this.licenseName,
    this.licenseUrl,
  });

  factory PlantIdentificationDescription.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationDescription(
        value: json['value'],
        citation: json['citation'],
        licenseName: json['license_name'],
        licenseUrl: json['license_url'],
      );
}

class PlantIdentificationImage {
  final String? value;
  final String? citation;
  final String? licenseName;
  final String? licenseUrl;

  PlantIdentificationImage({
    this.value,
    this.citation,
    this.licenseName,
    this.licenseUrl,
  });

  factory PlantIdentificationImage.fromJson(Map<String, dynamic> json) =>
      PlantIdentificationImage(
        value: json['value'],
        citation: json['citation'],
        licenseName: json['license_name'],
        licenseUrl: json['license_url'],
      );
}
