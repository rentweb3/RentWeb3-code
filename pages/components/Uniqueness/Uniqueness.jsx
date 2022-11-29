import { Center, Heading, VStack, Wrap, WrapItem } from "@chakra-ui/react";
import React from "react";
import UnqiuenessCard from "./UniquenessCard";

function Uniqueness() {
  return (
    <VStack
      bg={"black"}
      color={"white"}
      height={"fit-content"}
      width={"100%"}
      paddingTop={"5vh"}
      paddingBottom={"5vh"}
      spacing={5}
      justify={"center"}
      
    >
      <Center width={"100%"}>
        <Heading fontSize={"3em"}>Our Uniqueness</Heading>
      </Center>

      <Wrap justify={"center"} spacing={5}>
        <WrapItem>
          <UnqiuenessCard
            title={"Ease of Use"}
            description={
              "Our platform is easy to use and understand even for a non-technical person. We beleive that creating ease for you will help you to use our platform easily and that is our core value"
            }
            btnHandler={() => {
              alert(
                "We are currently working on Docs\nThank you for your patience "
              );
            }}
            btnCaption={"Know More"}
            bg={"#3182ce"}
          />
        </WrapItem>
        <WrapItem>
          <UnqiuenessCard
            title={"Dapps renting"}
            description={
              "Currently we are the only platform that provides the renting of Dapps as well as NFTs. We are on our way to implement the usecases of NFTs and we are "
            }
            btnHandler={() => {
              alert(
                "We are currently working on Docs\nThank you for your patience "
              );
            }}
            btnCaption={"Rent Dapp"}
            btnLink={"/RentDappInformation"}
            bg={"#ff3070"}
          />
        </WrapItem>
        <WrapItem>
          <UnqiuenessCard
            title={"Standardized"}
            description={
              "We follow the standards that has been made for a specific task like using ERC-4907 for NFT Renting whereas the competitors do not do that. Moreover , our smart contracts are well commented and easy to understand"
            }
            btnHandler={() => {
              alert(
                "We are currently working on Docs\nThank you for your patience "
              );
            }}
            btnCaption={"See Code"}
            btnLink={
              "https://github.com/rentweb3/RentWeb3-code/tree/master/contracts"
            }
            bg={"#38A169"}
          />
        </WrapItem>
      </Wrap>
    </VStack>
  );
}

export default Uniqueness;
