import { websiteRentContract } from "./WebsiteRent";

const axios = require("axios");
export const getAllDappsUris = async (contract, setter) => {
  let currentIPFSLink = await contract.allWebsitesIPFSCid();

  if (currentIPFSLink == "") {
    if (setter) {
      setter([]);
    }
    return [];
  }
  let link = `https://${currentIPFSLink}.ipfs.w3s.link/dappInfo.json`;
  const response = await axios.get(link);
  if (setter) {
    setter(response.data.dapps);
  }
  return response.data.dapps;
};

export const fetchDappsContent = async (Cids, setter, loader) => {
  let dappArray = [];
  await Cids.map(async (cid, index) => {
    let _link = `https://${cid}.ipfs.w3s.link/metadata.json`;
    const response = await axios.get(_link);
    let dapp = response.data;
    dapp.image = getImageLinkFromIPFS(dapp.image);
    if (dapp.url) {
      let renttime = await websiteRentContract.rentTime(dapp.url)
      if (parseInt(renttime) * 1000 > (new Date()).getTime()) {
        console.log("rented already !");
        dapp.rented = true;

      }
      else {
        console.log("Not rented !")
        dapp.rented = false;

      }

    }
    dappArray.push(dapp);

    if (setter != undefined && index + 1 == Cids.length) {
      console.log("Dapps are : ", dappArray);
      setter(dappArray);
      loader(false);
      return dappArray;
    }
  });
};
export function getImageLinkFromIPFS(cid) {
  let link = `https://${cid}.ipfs.w3s.link/img.PNG`;
  return link;
}
