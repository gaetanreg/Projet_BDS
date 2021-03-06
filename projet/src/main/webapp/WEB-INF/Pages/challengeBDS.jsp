<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,safari">
<link rel="stylesheet" href="CSS/challengeBDS.css" type="text/css">
<link rel="stylesheet" href="CSS/header.css" type="text/css">
<link rel="stylesheet" href="CSS/barremenuBDS.css" type="text/css">
<script src="js/jquery.js"></script>
<script src="js/challengeBDS.js"></script>
<title>BDS HEI</title>
</head>
<body>
	<header>
		<c:set var="pageSelectionnee" value="connecter" scope="request" />
		<%@ include file="header.jsp"%>
	</header>
	<section id="challengeBDS">
		<c:if test="${user_id != null}">
			<aside id="barremenuBDS">
				<c:set var="pageSelectionnee" value="connecter" scope="request" />
				<%@ include file="barremenuBDS.jsp"%>
			</aside>
			<h3>${bds.nom_resp}</h3>
			<div id="challenges">
				<fieldset>
					<legend>Liste des challenges</legend>
					<div id="listeChallenge">
						<table>
							<thead>
								<tr>
									<th>Date</th>
									<th>Nom</th>
									<th>Renseigner</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="challenge" items="${challenges}">
									<tr>
										<td><fmt:formatDate value="${challenge.date_challenge}"
												pattern="dd/MM/YYYY" /></td>
										<td>${challenge.nom_challenge}</td>
										<td>Oui</td>
										<td><span class="info" id="${challenge.id_challenge}">Info</span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<c:forEach var="challenge" items="${challenges}">
						<div class="infoChallenge" id="info${challenge.id_challenge}">
							<table>
								<caption>${challenge.nom_challenge}
									(
									<fmt:formatDate value="${challenge.date_challenge}"
										pattern="dd/MM/YYYY" />
									)
								</caption>
								<thead>
									<tr>
										<th>Identifiant</th>
										<th>Prénom Nom</th>
										<th>Présence</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="participant" items="${participants}">
										<c:if
											test="${participant.id_challenge == challenge.id_challenge}">
											<tr>
												<td>${participant.id_etudiant}</td>
												<td>${participant.etudiant.prenom}
													${participant.etudiant.nom}</td>
												<td><c:if test="${participant.presence == 1}">
														<span class="oui">Oui</span>
													</c:if>
													<c:if test="${participant.presence == 0}">
														<span class="non">Non</span>
													</c:if>
													<c:if test="${participant.presence == -1}">
														<span class="NC">NC</span>
													</c:if></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
							<input type="button" value="Modifier" class="modifier"
								id="${challenge.id_challenge}" />
						</div>
						<div class="modifInfoChallenge"
							id="modifInfo${challenge.id_challenge}">
							<form method="POST" action="presencechallenge">
								<table>
									<caption>${challenge.nom_challenge}
										(
										<fmt:formatDate value="${challenge.date_challenge}"
											pattern="dd/MM/YYYY" />
										)
									</caption>
									<thead>
										<tr>
											<th>Identifiant</th>
											<th>Prénom Nom</th>
											<th>Présence</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="participant" items="${participants}">
											<c:if
												test="${participant.id_challenge == challenge.id_challenge}">
												<tr>
													<td>${participant.id_etudiant}</td>
													<td>${participant.etudiant.prenom}
														${participant.etudiant.nom}</td>
													<td><select
														name="presence_${participant.id_etudiant}${participant.id_challenge}">
															<option value="1">Oui</option>
															<option value="0">Non</option>
													</select></td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
								<input type="hidden" class="id_challenge" name="id_challenge"
									value="${challenge.id_challenge}" /> <input type="submit"
									value="Valider" />
							</form>
						</div>
					</c:forEach>
				</fieldset>
			</div>
			<div id="newChallenge">
				<fieldset>
					<legend>Nouveau Challenge</legend>
					<label for="ajouchallenge">Type de challenge :</label> <select
						id="ajouchallenge" name="ajouchallenge">
						<option value="new">New</option>
						<c:forEach var="typechallenge" items="${typeschallenge}">
							<option value="${typechallenge.nom_challenge}">${typechallenge.nom_challenge}</option>
						</c:forEach>
					</select>
					<div id="new">
						<form method="post" action="challengebds">
							<input type="hidden" class="type" name="type"
								value="newChallenge" />
							<fieldset>
								<legend>Informations</legend>
								<label for="id_challenge">Identifiant</label> <input type="text"
									name="id_challenge" id="ajouid_challenge" required="required" /><br />
								<label for="nom_challenge">Nom</label> <input type="text"
									name="nom_challenge" id="ajounom_challenge" required="required" /><br />
								<label for="date_challenge">Date</label> <input type="date"
									name="date_challenge" id="ajoudate_challenge"
									required="required" /><br /> <label for="heure_challenge">Heure</label>
								<input type="time" name="heure_challenge"
									id="ajouheure_challenge" required="required" /><br /> <label
									for="description">Description</label><br />
								<textarea title="descritption" name="description"
									id="ajoudescription" cols="70px" rows="5px" class="description"></textarea>
							</fieldset>
							<div class="adresses">
								<fieldset>
									<legend>Adresse</legend>
									<label for="ajoulieu">Lieu</label> <select name="ajoulieu"
										id="ajoulieu">
										<c:forEach var="adresse" items="${adresses}">
											<option value="${adresse.id}">${adresse.nom}</option>
										</c:forEach>
									</select> <img src="IMAGE/main/plus.png" class="plus" width="25px"
										height="25px">
								</fieldset>
							</div>
							<input type="submit" class="ajouterChall" value="Ajouter" />
						</form>
						<div class="newadresse">
							<fieldset>
								<legend>Adresse</legend>
								<form>
									<label for="nom">Nom du Site</label> <input type="text"
										name="ajounom" id="ajounom" required="required" /><br /> <label
										for="num">Numéro</label> <input type="text" name="ajounum"
										id="ajounum" required="required" /><br /> <label for="rue">Rue</label>
									<input type="text" name="ajourue" id="ajourue"
										required="required" /><br /> <label for="cp">Code
										Postal</label> <input type="text" name="ajoucp" id="ajoucp"
										required="required" /><br /> <label for="ville">Ville</label>
									<input type="text" name="ajouville" id="ajouville"
										required="required" /><br /> <label for="pays">Pays</label> <input
										type="text" name="ajouville" id="ajoupays" required="required" /><br />
									<input type="button" id="btnAjou_ajouterAdr" value="Valider" />
									<input type="button" class="retour" value="Retour" />
								</form>
							</fieldset>
						</div>
					</div>
				</fieldset>
			</div>
			<div id="suprChallenge">
				<fieldset>
					<legend>Supprimer un challenge</legend>
					<form method="post" action="challengebds">
						<input type="hidden" class="type" name="type"
							value="suprChallenge" /> <label for="id_challenge">Selectionner
							un challenge</label> <select class="id_challenge" name="id_challenge">
							<c:forEach var="challenge" items="${challenges}">
								<option value="${challenge.id_challenge}">
									${challenge.nom_challenge} (
									<fmt:formatDate value="${challenge.date_challenge}"
										pattern="dd MMMM YYYY" />)
								</option>
							</c:forEach>
						</select> <br /> <input type="submit" value="Supprimer">
					</form>
				</fieldset>
			</div>
			<div id="modifChallenge">
				<fieldset>
					<legend>Modifier Challenge</legend>
					<label for="modifchallenge">Choisissez un challenge :</label> <select
						id="modifchallenge" name="modifchallenge">
						<c:forEach var="challenge" items="${challenges}">
							<option value="${challenge.id_challenge}">
								${challenge.nom_challenge} (${challenge.date_challenge})</option>
						</c:forEach>
					</select>
					<form method="post" action="challengebds">
						<div id="modif_InfoChallenge">
							<input type="hidden" class="type" name="type"
								value="validerModifChallenge" /> <input type="hidden"
								name="modifid_challenge" id="modifid_challenge"
								required="required" /> <label for="nom_challenge">Nom :</label>
							<input type="text" name="modifnom_challenge"
								id="modifnom_challenge" required="required" /><br /> <label
								for="date_challenge">Date :</label> <input type="date"
								name="modifdate_challenge" id="modifdate_challenge"
								required="required" /><br /> <label for="heure_challenge">Heure
								:</label> <input type="time" name="modifheure_challenge"
								id="modifheure_challenge" required="required" /><br /> <label
								for="modifdescription">Description :</label><br />
							<textarea title="modifdescription" name="modifdescription"
								id="modifdescription" cols="70px" rows="5px" class="description">${typechallenge.description_challenge}</textarea>
						</div>
						<div class="adresses">
							<fieldset>
								<legend>Adresse</legend>
								<label for="modiflieu">Lieu</label> <select name="modiflieu"
									id="modiflieu">
									<c:forEach var="adresse" items="${adresses}">
										<option value="${adresse.id}">${adresse.nom}</option>
									</c:forEach>
								</select> <img src="IMAGE/main/plus.png" class="plus" width="25px"
									height="25px">
							</fieldset>
						</div>
						<input type="submit" value="Modifier" class="btn_modifChallenge" />
					</form>
					<div class="newadresse">
						<fieldset>
							<legend>Adresse</legend>
							<form>
								<label for="modifnom">Nom du Site</label> <input type="text"
									name="modifnom" id="modifnom" required="required" /><br /> <label
									for="modifnum">Numéro</label> <input type="text"
									name="modifnum" id="modifnum" required="required" /><br /> <label
									for="modifrue">Rue</label> <input type="text" name="modifrue"
									id="modifrue" required="required" /><br /> <label
									for="modifcp">Code Postal</label> <input type="text"
									name="modifcp" id="modifcp" required="required" /><br /> <label
									for="modifville">Ville</label> <input type="text"
									name="modifville" id="modifville" required="required" /><br />
								<label for="modifpays">Pays</label> <input type="text"
									name="modifpays" id="modifpays" required="required" /><br /> <input
									type="button" id="btnModif_ajouterAdr" value="Valider" /> <input
									type="button" class="retour" value="Retour" />
							</form>
						</fieldset>
					</div>
				</fieldset>
			</div>
		</c:if>
	</section>
</body>
</html>